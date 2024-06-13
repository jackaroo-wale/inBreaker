class PrivateMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation

  def create
    @private_message = @conversation.private_messages.build(private_message_params)
    @private_message.user = current_user

    if @private_message.save
      # Broadcast the message if needed using ActionCable
      redirect_to team_conversation_path(@conversation.team, @conversation)
    else
      render 'conversations/show'
    end
  end

  private

  def private_message_params
    params.require(:private_message).permit(:content)
  end

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
end
