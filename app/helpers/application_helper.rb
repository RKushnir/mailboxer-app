module ApplicationHelper
  def notice
    flash[:notice]
  end

  def alert
    flash[:alert]
  end
end
