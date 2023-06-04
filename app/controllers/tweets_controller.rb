class TweetsController < ApplicationController

    def index
        tweets = current_user.tweets.all
        render json: {
            status: 200,
            mesasge: "ok",
            data: tweets.map(&:new_attribute)
        }, status: :ok
    end

    def show
        tweet = Tweet.find(params[:id])
        render json: {
            status: 200,
            mesasge: "ok",
            data: tweet.new_attribute
        }, status: :ok
    end

    def count_likes
        @tweet = Tweet.find(params[:id])
        @likes_count = @tweet.likes.count
        render json: {
            message: "succes count the likes",
            data: {
                likes: @likes_count
            }
        }, status: :ok
    end

    def create
        tweet = current_user.tweets.new(tweet_params)
        tweet.images.each { |image| image.user_email = current_user.email }
        if tweet.save
            
            render json: {
                status: 200,
                mesasge: "ok",
                data: tweet.new_attribute
            }, status: :ok
        else
            render json: { errors: tweet.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        @tweet = current_user.tweets.find_by(id: params[:id])
        @tweet.assign_attributes(tweet_params)
        @tweet.images.each { |image| image.user_email = current_user.email }
      
        if @tweet.save 
          render json: {
            status: 200,
            message: :ok,
            data: @tweet.new_attribute 
          }, status: :ok
        else
          render json: {
            status: 422,
            message: @tweet.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

    private

    def tweet_params
        params.permit(:caption, images_attributes: [:id, :image, :_destroy])
    end
end