class NotificationsController < ApplicationController
    def index
        @notifications = current_user.notifications.order(created_at: :desc)
        render json: {
            status: 200,
            message: :ok,
            data: @notifications
        }, status: :ok
    end
  
    def mark_as_read
        @notification = current_user.notifications.find(params[:id])
        @notification.update(read_at: Time.current)
        head :no_content
    end
end
