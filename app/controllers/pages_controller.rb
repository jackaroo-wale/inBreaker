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
    session[:current_question_index] = 0 # Reset the current question index when the user starts the game
  end

  def next_question
    session[:current_question_index] ||= 0
    session[:current_question_index] += 1

    redirect_to play_team_path
  end

  def check_answer
    weekly_answer = WeeklyAnswer.find_by(id: params[:member_answer][:weekly_answer_id])

    if weekly_answer.nil?
      flash[:error] = "Weekly answer not found"
      redirect_to root_path
      return
    end

    member = current_user.members.find_by(team_id: params[:id])

    member_answer = MemberAnswer.new(
      member: member,
      weekly_answer_id: weekly_answer.id,
      answerable: weekly_answer,
      selected: params[:member_answer][:selected]
    )

    if params[:member_answer][:selected] == weekly_answer.content
      member_answer.correct = true
    else
      member_answer.correct = false
    end

    if member_answer.save
      if member_answer.correct
        member.increment!(:weekly_points)
        member.increment!(:total_points)
      end

      session[:current_question_index] ||= 0
      session[:current_question_index] += 1

      if session[:current_question_index] < @question_data.length
        redirect_to play_team_path(@team)
      else
        redirect_to teams_path
      end
    else
      flash[:error] = "Failed to save answer"
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
    @members = @team.members.includes(user: { weekly_answers: :weekly_question })

    @question_data = []
    @seen_questions = Set.new

    @members.each do |member|
      member.user.weekly_answers.each do |weekly_answer|
        unless @seen_questions.include?(weekly_answer.weekly_question.id)
          question_data = []
          question_data << weekly_answer.weekly_question
          question_data << weekly_answer
          question_data << weekly_answer.wrong_answers.split(',')
          question_data << (member.user.profile_image.attached? ? url_for(member.user.profile_image) : nil)
          @question_data << question_data

          @seen_questions.add(weekly_answer.weekly_question.id)
        end
      end
    end
  end
end
