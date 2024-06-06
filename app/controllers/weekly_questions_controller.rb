class WeeklyQuestionsController < ApplicationController
  before_action :set_weekly_question, only: [:show, :create_answer]

  def index
    @weekly_questions = WeeklyQuestion.all
    @weekly_answer = current_user.weekly_answers.build
  end

  def show
    @weekly_question = WeeklyQuestion.find(params[:id])
  end

  def new
    @weekly_question = WeeklyQuestion.new
  end

  def create_answer
    @weekly_question = WeeklyQuestion.find(params[:id])
    user_answer = params[:user_answer]
    correct_answer = @weekly_question.correct_answer

    if user_answer == correct_answer
      flash[:success] = "Congratulations! Your answer is correct."
    else
      flash[:error] = "Oops! Your answer is incorrect. The correct answer is '#{correct_answer}'."
    end

    redirect_to weekly_question_path(@weekly_question)
  end

  # def create_answer
  #   @weekly_answer = WeeklyAnswer.new(weekly_answer_params)
  #   @weekly_answer.weekly_question = @weekly_question
  #   @weekly_answer.user = current_user

  #   if @weekly_answer.save
  #     redirect_to @weekly_question, notice: 'Answer was successfully created.'
  #   else
  #     render :show
  #   end
  # end

  # def create_answer
  #   @weekly_question = WeeklyQuestion.find(params[:id])
  #   @weekly_answer = current_user.weekly_answers.build(weekly_question: @weekly_question, content: params[:content])

  #   if @weekly_answer.save
  #     if @weekly_answer.correct_answer?
  #       flash[:success] = "Correct answer! Well done."
  #     else
  #       flash[:error] = "Incorrect answer. Try again next time."
  #     end
  #   else
  #     flash[:error] = "Failed to submit answer."
  #   end

  #   redirect_to weekly_questions_path
  # end

  private

  def set_weekly_question
    @weekly_question = WeeklyQuestion.find(params[:id])
  end

  def weekly_answer_params
    params.require(:weekly_answer).permit(:content, :wrong_answers)
  end
end
