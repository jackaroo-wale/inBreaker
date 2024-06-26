class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  before_action :authenticate_user!
  before_action :set_team, only: [:play, :check_answer, :next_question]
  before_action :set_question_data, only: [:play, :check_answer, :next_question]

  def home
    @team = current_user.teams.first
    @initial_questions = InitialQuestion.all
    @answer = InitialAnswer.new
    @users = User.all
  end

  def play
    # @team from callback
    @team.week_number = 1 if @team.week_number < 1
    @team.save

    if @question_data.empty?
      flash[:notice] = "No questions found"
      redirect_to team_path(@team)
    else
      session[:current_question_index] = 0
    end
  end

  def next_question
    session[:current_question_index] ||= 0
    session[:current_question_index] += 1

    if session[:current_question_index] < @question_data.length
      redirect_to play_team_path(@team)
    else
      redirect_to team_path(@team)
    end
  end

  def check_answer
    if @team.week_number == 1
      answer = InitialAnswer.find_by(id: params[:member_answer][:initial_answer_id])
    else
      answer = WeeklyAnswer.find_by(id: params[:member_answer][:weekly_answer_id])
    end

    if answer.nil?
      flash[:notice] = "Answer not found"
      redirect_to root_path and return
    end

    member = current_user.members.find_by(team_id: @team.id)

    member_answer = MemberAnswer.new(
      member: member,
      answerable: answer,
      selected: params[:member_answer][:selected]
    )

    if params[:member_answer][:selected] == answer.content
      member_answer.correct = true
    else
      member_answer.correct = false
    end

    if member_answer.save
      if member_answer.correct
        member.weekly_points += 8
        member.total_points += 8
        member.save
      end


    else
      flash[:notice] = "Failed to save answer"
      redirect_to root_path
    end
  end


  private

  def member_answer_params
    params.require(:member_answer).permit(:selected, :user_id, :weekly_answer_id)
  end

  def weekly_answer_params
    params.require(:weekly_answer).permit(:user_id, :weekly_question_id)
  end

  def set_team
    @team = Team.find(params[:id])
  end

  def set_question_data
    member = current_user.members.find_by(team_id: @team.id)
    member.weekly_points = 0
    member.save

    @members = @team.members.includes(user: { weekly_answers: :weekly_question, initial_answers: :initial_question })
    @question_data = []
    current_user_member_answers = MemberAnswer.where(member: current_user.members).pluck(:answerable_id, :answerable_type).to_set
    @members.each do |member|
      next if member.user == current_user
      answers = @team.week_number == 1 ? member.user.initial_answers : member.user.weekly_answers
      answers.each do |answer|
        next if current_user_member_answers.include?([answer.id, answer.class.name])
        # raise
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
