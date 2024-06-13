class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: [:index, :create, :show]

  def index
    @team = Team.find(params[:team_id])
    @conversations = @team.conversations.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
    @teams = current_user.teams.includes(members: :user)
    @members = @teams.flat_map(&:members).map(&:user).uniq
  end

  def create
    @team = Team.find(params[:team_id])
    @conversation = @team.conversations.new(conversation_params)
    if @conversation.save
      redirect_to team_conversation_path(@team, @conversation)
    else
      render :index
    end
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
