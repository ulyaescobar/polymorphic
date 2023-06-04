# To deliver this notification:
#
# TestNotification.with(post: @post).deliver_later(current_user)
# TestNotification.with(post: @post).deliver(current_user)

class TestNotification < Noticed::Base

  deliver_by :database
   
  def message
    "Hello! You have a new notification."
  end

end

