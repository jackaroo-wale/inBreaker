class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: [:index, :create, :show]

  def index
    @conversations = @team.conversations.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
  end

  def create
    @conversation = Conversation.between(params[:sender_id], params[:receiver_id], @team.id).first_or_create!(conversation_params)
    redirect_to team_conversation_path(@team, @conversation)
  end

  def show
    @conversation = @team.conversations.find(params[:id])
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
