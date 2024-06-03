class WeeklyAnswersController < ApplicationController
  def create
    @weekly_answers = WeeklyAnswers.new(weekly_answers_params)
    if @weekly_answers.save
      redirect_to @weekly_answers
    else
      render 'new'
    end
  end

  private

  def weekly_answers_params
    params.require(:weekly_answers).permit(:content, :wrong_answers)
  end
end
