class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  helper_method :conversations, :conversation

  def create
    recipient_emails = conversation_params(:recipients).split(',')
    recipients = User.where(email: recipient_emails).all

    conversation = current_user.
      send_message(recipients, *conversation_params(:body, :subject)).conversation

    redirect_to conversation
  end

  def reply
    current_user.reply_to_conversation(conversation, *message_params(:body, :subject))
    redirect_to conversation
  end

  def destroy
    conversation.move_to_trash(current_user)
    redirect_to :conversations
  end

  private

  def conversations
    @conversations ||= current_user.mailbox.conversations
  end

  def conversation
    @conversation ||= params[:id] ? conversations.find(params[:id]) : conversations.new
  end

  def conversation_params(*keys)
    fetch_params(:conversation, *keys)
  end

  def message_params(*keys)
    fetch_params(:message, *keys)
  end

  def fetch_params(key, *subkeys)
    params[key].instance_eval do
      case subkeys.size
      when 0 then self
      when 1 then self[subkeys.first]
      else subkeys.map{|k| self[k] }
      end
    end
  end
end
