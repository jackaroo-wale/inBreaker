class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @initial_questions = InitialQuestion.all
    @answer = InitialAnswer.new
    @users = User.all
  end
end
