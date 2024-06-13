class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team

  def show
    @chatroom = @team.chatrooms.find(params[:id])
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    @messages = @chatroom.messages.includes(:user)
  end

  def create
    @chatroom = @team.chatrooms.build(chatroom_params)
    if @chatroom.save
      redirect_to team_chatroom_path(@team, @chatroom), notice: 'Chatroom created successfully.'
    else
      redirect_to team_path(@team), alert: 'Failed to create chatroom.'
    end
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end

  def chatroom_params
    params.require(:chatroom).permit(:name)
  end
end
