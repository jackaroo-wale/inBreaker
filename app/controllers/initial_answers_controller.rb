class InitialAnswersController < ApplicationController
  def create
    @initial_answer = InitialAnswer.new(initial_answer_params)
    @initial_question = InitialQuestion.find(params[:initial_question_id])

    unless @initial_question.id == InitialQuestion.last.id
      next_initial_question = InitialQuestion.find(@initial_question.id + 1)
    end

    @initial_answer.initial_question = @initial_question
    @initial_answer.user = current_user

    if @initial_answer.save
      # @initial_answer.wrong_answers = generate_and_save_false_answers(@initial_question, @initial_answer.content)
      # p "WE HAVE A PROBLEM" unless @initial_answer.save!

      if next_initial_question
        redirect_to initial_question_path(next_initial_question), notice: "Your answer has been saved successfully."
      else
        redirect_to root_path, notice: "Welcome to inBreaker! Thank you for submitting your answers! 🎉
        Get ready to dive into the game and see how well you can score against your teammates.
        We’re excited to see you play! Have fun!"
      end
    else
      redirect_to initial_question_path(@initial_question), alert: "Please put in your answer before submitting"
    end
  end

  def show
    @initial_answer = InitialAnswer.find(params[:id])
  end

  private

  def initial_answer_params
    params.require(:initial_answer).permit(:content)
  end
end
