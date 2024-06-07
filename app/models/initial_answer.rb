class InitialAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :initial_question

  validates :content, presence: true

  after_save :set_wrong_answers, if: -> { saved_change_to_content? }

  def set_wrong_answers
    client = OpenAI::Client.new
    input_message = "The question is #{initial_question}. "
    input_message += "This is the correct answer: #{content}. "
    input_message += "Generate a comma-separated string of three unique plausible answers to the question
    #{initial_question}, which are different from the correct answer (which is #{content}) and are realistic responses
    to the question, exclude any additional characters and as one string."

    chaptgpt_response = client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: input_message }]
      })

    new_wrong_answers = chaptgpt_response["choices"][0]["message"]["content"]

    update(wrong_answers: new_wrong_answers)
    return new_wrong_answers
  end

  def wrong_answers
    if super.blank?
      set_wrong_answers
    else
      super
    end
  end
end
