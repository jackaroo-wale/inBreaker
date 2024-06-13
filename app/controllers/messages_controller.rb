class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom

  def create
    @message = @chatroom.messages.build(message_params)
    @message.user = current_user

    if @message.save
      ChatroomChannel.broadcast_to(@chatroom, render_to_string(partial: 'messages/message', locals: { message: @message }))
      head :ok
    else
      redirect_to team_chatroom_path(@chatroom.team, @chatroom), alert: 'Message could not be sent.'
    end
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
