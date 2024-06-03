class InitialAnswersController < ApplicationController
  def create
    @initial_answers = InitialAnswers.new(initial_answers_params)
    if @initial_answers.save
      redirect_to @initial_answers
    else
      render 'new'
    end
  end

  private

  def initial_answers_params
    params.require(:initial_answers).permit(:content, :wrong_answers)
  end
end
