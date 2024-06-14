# app/controllers/conversations_controller.rb

class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: [:index, :create, :show]

  def index
    @conversations = Conversation.where(team_id: @team.id)
    @members = @team.members.where.not(user_id: current_user.id).map(&:user).uniq
  end

  def create
    @conversation = Conversation.find_or_create_by(conversation_params)

    if @conversation.persisted?
      redirect_to team_conversation_path(@team, @conversation)
    else
      render :index
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
    @private_message = PrivateMessage.new
  end

  private

  def conversation_params
    params.permit(:sender_id, :receiver_id, :team_id)
  end

  def set_team
    @team = Team.find(params[:team_id])
  end
end
