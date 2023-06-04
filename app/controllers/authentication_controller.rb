require 'json_web_token'
class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request, only: [:authenticate]
    
    def authenticate
        user = User.find_by_email(params[:email])

        if user && user.authenticate(params[:password])
            token = JsonWebToken.encode(user_id: user.id)
            render json: { token: token, user: user }
        else
            render json: { error: 'Invalid username or password' }, status: :unauthorized
        end
    end

    def user_login
        user = current_user
        render json: {
            status: 200,
            data: {
                user: user
            }
        }, status: :ok
    end

end