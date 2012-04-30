class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def create
    p params[:message]
    render text: 'hello'
  end
end
