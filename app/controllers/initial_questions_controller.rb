class InitialQuestionsController < ApplicationController
  def index
    @initial_questions = InitialQuestion.all
  end

  def show
    @initial_question = InitialQuestion.find(params[:id])
  end

  def new
    @initial_question = InitialQuestion.new
  end

  def create
    @initial_question = InitialQuestion.new(initial_question_params)
    if @initial_question.save
      redirect_to @initial_question
    else
      render 'new'
    end
  end

  private

  def initial_question_params
    params.require(:initial_question).permit(:content)
  end
end
