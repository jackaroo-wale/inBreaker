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
      # need to create a elsif about the final card then redirect
      @initial_answer.wrong_answers = generate_and_save_false_answers(@initial_question, @initial_answer.content)
      p "WE HAVE A PROBLEM" unless @initial_answer.save!
      if next_initial_question
        redirect_to initial_question_path(next_initial_question), notice: "Your answer has been saved successfully."
      else
        redirect_to root_path
      end
    else
      render 'new'
    end
  end

  def show
    @initial_answer = InitialAnswer.find(params[:id])
  end

  private

  def initial_answer_params
    params.require(:initial_answer).permit(:content)
  end

  def generate_and_save_false_answers(initial_question, initial_answer)
    # Call OpenAI service to generate false answers
    # Save false answers along with the question and the correct answer

    client = OpenAI::Client.new

    input_message = "The question is #{initial_question}"
    input_message += "This is the correct answer: #{initial_answer}"
    input_message += "Generate comma-separated string of three unique plausible answers to the question which are different from the correct answer and realistic responses to the question, exclude any additional characters.
    "


    chaptgpt_response = client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: input_message }]
      })

    @generated_response = chaptgpt_response["choices"][0]["message"]["content"]

    p chaptgpt_response
    p @generated_response
    @generated_response.split
  end
end
