class WeeklyQuestionsController < ApplicationController
  def index
    @weekly_questions = WeeklyQuestion.all
  end

  def show
    @weekly_question = WeeklyQuestion.find(params[:id])
  end

  def new
    @weekly_question = WeeklyQuestion.new
  end

  def create
    @weekly_question = WeeklyQuestion.new(weekly_question_params)
    if @weekly_question.save
      redirect_to @weekly_question
    else
      render 'new'
    end
  end

  private

  def weekly_question_params
    params.require(:weekly_question).permit(:content, :week_number)
  end
end
