class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  before_action :authenticate_user!
  before_action :set_team, only: [:play]

  def home
    @initial_questions = InitialQuestion.all
    @answer = InitialAnswer.new
    @users = User.all
  end

  def play
    @members = @team.members.includes(weekly_answers: :user)
    member = current_user.members.find_by(team_id: @team.id)
    @current_question_index = session[:current_question_index] || 0
    @current_question = member.team.weekly_questions[@current_question_index]
  end

  def next_question
    session[:current_question_index] ||= 0
    session[:current_question_index] += 1

    redirect_to play_team_path
  end

  def check_answer
    weekly_answer = WeeklyAnswer.find(member_answer_params[:weekly_answer_id])
    member = current_user.members.find_by(team_id: @team.id)
    member_answer = MemberAnswer.new(
      member: member,
      weekly_answer_id: weekly_answer.id,
      answerable: weekly_answer
    )
    member_answer.selected = member_answer_params[:selected] == weekly_answer.content

    if member_answer.save
      if member_answer.correct
        member = Member.find(member_answer_params[:user_id])
        member.increment!(:weekly_points)
        member.increment!(:total_points)
      end

      redirect_to next_question_path
    else
      flash[:error] = "Failed to save answer"
      redirect_to root_path
    end
  end

  private

  def member_answer_params
    params.require(:member_answer).permit(:selected, :weekly_answer_id)
  end

  def weekly_answer_params
    params.require(:weekly_answer).permit(:user_id, :weekly_question_id)
  end

  def set_team
    @team = Team.find(params[:id])
  end
end
