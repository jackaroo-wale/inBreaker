class InitialAnswersController < ApplicationController
  def create
    @initial_answer = InitialAnswer.new(initial_answer_params)
    @initial_question = InitialQuestion.find(params[:initial_question_id])
    next_initial_question = InitialQuestion.find(@initial_question.id + 1)
    @initial_answer.initial_question = @initial_question
    @initial_answer.user = current_user
    if @initial_answer.save
      # need to create a elsif about the final card then redirect 
      redirect_to initial_question_path(next_initial_question)
    else
      render 'new'
    end
  end

  def show
    @initial_answer = InitialAnswer.find(params[:id])
  end

  private

  def initial_answer_params
    params.require(:initial_answer).permit(:content, :wrong_answers)
  end
end
