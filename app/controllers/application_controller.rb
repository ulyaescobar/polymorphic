require 'json_web_token'

class ApplicationController < ActionController::API
    before_action :authenticate_request

    attr_reader :current_user

    private

    def authenticate_request
      header = request.headers['Authorization']
      if header.present?
        header = header.split(' ').last
    
        begin
          decoded = JsonWebToken.decode(header)
          if decoded.present? && decoded[:user_id].present?
            @current_user = User.find(decoded[:user_id])
          else
            render json: { error: 'Invalid token' }, status: :unauthorized
          end
        rescue ActiveRecord::RecordNotFound => e
          render json: { error: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
          render json: { error: e.message }, status: :unauthorized
        end
      else
        render json: { error: 'Authorization header is missing' }, status: :unauthorized
      end
    end

end


