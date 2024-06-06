class WeeklyAnswersController < ApplicationController
  def create
    @weekly_answer = WeeklyAnswer.new(weekly_answer_params)
    @weekly_answer.user = current_user

    if @weekly_answer.save
      redirect_to weekly_questions_path, notice: 'Answer was successfully created.'
    else
      redirect_to weekly_questions_path, alert: 'There was an error saving your answer.'
    end
  end

  private

  def weekly_answer_params
    params.require(:weekly_answer).permit(:content, :weekly_question_id, wrong_answers: [])
  end
end
