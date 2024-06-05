class InitialAnswersController < ApplicationController
  def create
    @initial_answer = InitialAnswer.new(initial_answer_params)
    @initial_question = InitialQuestion.find(params[:initial_question_id])
    @initial_answer.initial_question = @initial_question
    @initial_answer.user = current_user
    if @initial_answer.save
      redirect_to initial_answer_path(@initial_answer)
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
