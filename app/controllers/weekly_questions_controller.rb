class WeeklyQuestionsController < ApplicationController
  before_action :set_team, only: [:index, :show, :create_answer]
  before_action :set_weekly_question, only: [:show, :create_answer]

  def index
    @weekly_questions = @team.weekly_questions
    @weekly_answer = current_user.weekly_answers.build
  end

  def show
    if @team.week_number == 1
      @initial_answer = InitialAnswer.find_by(initial_question_id: @weekly_question.id, user_id: current_user.id)
    else
      @weekly_answers = @weekly_question.weekly_answers.includes(:user)
      @weekly_answer = @weekly_question.weekly_answers.find_by(user_id: current_user.id)
    end

    @member = current_user.members.find_by(team: @team)

    if @initial_answer
    @answer_content = @initial_answer.content
    @answer_type = "Initial"
    @wrong_answers = @initial_answer.wrong_answers.split(',')
  elsif @weekly_answer
    @answers = [
      @weekly_answer.content,
      @weekly_answer.wrong_answers.split(',')[0],
      @weekly_answer.wrong_answers.split(',')[1],
      @weekly_answer.wrong_answers.split(',')[2]
    ].shuffle
    @answer_type = "Weekly"
    @wrong_answers = @weekly_answer.wrong_answers.split(',')
  else
    # Handle case when no answer is found
    @answer_content = "No answer found"
    @answer_type = "None"
    @wrong_answers = []
  end
  end

  def create_answer
    @weekly_answer = WeeklyAnswer.find(params[:weekly_answer_id])
    @member = current_user.members.find_by(team: @team)

    user_answer = params[:user_answer]
    correct_answer = @weekly_answer.content
    correct = user_answer == correct_answer

    MemberAnswer.create!(
      member: @member,
      weekly_answer: @weekly_answer,
      correct: correct
    )

    if correct
      flash[:success] = "Congratulations! Your answer is correct."
      @member.increment!(:score) if @member
    else
      flash[:error] = "Oops! Your answer is incorrect. The correct answer is '#{correct_answer}'."
    end

    redirect_to weekly_question_path(@weekly_question, team_id: @team.id)
  end

  private

  def available_weekly_question_for_user_in_team(user)
    answered_question_ids = user.weekly_answers.pluck(:weekly_question_id)
    team_questions = user.team.weekly_questions
    unanswered_questions = team_questions.where.not(id: answered_question_ids)
    unanswered_questions.sample
  end

  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_weekly_question
    if @team.week_number == 1
      @weekly_question = WeeklyQuestion.find_by(content: "Sample question 1")
    else
      @weekly_question = WeeklyQuestion.find(params[:id])
    end
  end
end
