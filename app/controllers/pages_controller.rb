class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  before_action :authenticate_user!
  before_action :set_team, only: [:play, :check_answer]
  before_action :set_question_data, only: [:play, :check_answer]

  def home
    @initial_questions = InitialQuestion.all
    @answer = InitialAnswer.new
    @users = User.all
  end

  def play
    @team.week_number = 1 if @team.week_number < 1
    @team.save

    if @question_data.empty?
      flash[:notice] = "Answer not found"
      redirect_to team_path(@team)
    else
      session[:current_question_index] = 0
    end
  end

  def next_question
    session[:current_question_index] ||= 0
    session[:current_question_index] += 1

    redirect_to play_team_path
  end

  def check_answer
    if @team.week_number == 1
      answer = InitialAnswer.find_by(id: params[:member_answer][:initial_answer_id])
    else
      answer = WeeklyAnswer.find_by(id: params[:member_answer][:weekly_answer_id])
    end

    if answer.nil?
      render json: { error: "Answer not found" }, status: :not_found and return
    end

    member = current_user.members.find_by(team_id: @team.id)

    member_answer = MemberAnswer.new(
      member: member,
      answerable: answer,
      selected: params[:member_answer][:selected]
    )

    member_answer.correct = params[:member_answer][:selected] == answer.content

    if member_answer.save
      if member_answer.correct
        member.weekly_points += 8
        member.total_points += 8
        member.save
      end

      render json: {
        correct: member_answer.correct,
        correct_answer: answer.content,
        next_question_index: session[:current_question_index] + 1,
        total_questions: @question_data.length
      }
    else
      render json: { error: "Failed to save answer" }, status: :unprocessable_entity
    end
  end

  private

  def member_answer_params
    params.require(:member_answer).permit(:selected, :user_id, :weekly_answer_id)
  end

  def set_team
    @team = Team.find(params[:id])
  end

  def set_question_data
    @members = @team.members.includes(user: { weekly_answers: :weekly_question, initial_answers: :initial_question })
    @question_data = []
    current_user_member_answers = MemberAnswer.where(member: current_user.members).pluck(:answerable_id, :answerable_type).to_set
    @members.each do |member|
      next if member.user == current_user
      answers = @team.week_number == 1 ? member.user.initial_answers : member.user.weekly_answers
      answers.each do |answer|
        next if current_user_member_answers.include?([answer.id, answer.class.name])
        question_data = [
          @team.week_number == 1 ? answer.initial_question : answer.weekly_question,
          answer,
          answer.wrong_answers.split(','),
          (member.user.profile_image.attached? ? url_for(member.user.profile_image) : nil)
        ]
        @question_data << question_data
      end
    end
    return @question_data
  end
end
