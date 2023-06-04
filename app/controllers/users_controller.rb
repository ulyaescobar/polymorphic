# app/controllers/users_controller.rb
class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    before_action :authenticate_request, except: [:create]

    # GET /users
    def index
        @users = User.all
        render json: @users
    end

    # GET /users/1
    def show
        render json: @user
    end

    # POST /users
    def create
        @user = User.new(user_params)

        if @user.save
        render json: @user.new_attribute, status: :created
        else
        render json: @user.errors, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /users/1
    def update
        if @user.update(user_params)
        render json: @user
        else
        render json: @user.errors, status: :unprocessable_entity
        end
    end

    def update_avatar
        @user = current_user
        if @user.avatar.update(avatar_params)
          render json: { message: "Avatar updated successfully", data: @user.new_attribute}, status: :ok
        else
          render json: { error: user.avatar.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # DELETE /users/1
    def destroy
        @user.destroy
        head :no_content
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find(params[:id])
    end

    def avatar_params
        params.permit(:image)
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end