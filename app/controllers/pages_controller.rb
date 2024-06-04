class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @initial_questions = InitialQuestion.all
  end
end
