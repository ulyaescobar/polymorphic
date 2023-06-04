class LikesController < ApplicationController
    before_action :find_tweet
    # after_action :broadcast_like, only: [:create]

    def create
        # Cek apakah user sudah menyukai tweet tersebut
        if @tweet.likes.exists?(user_id: current_user.id)
          render json: { error: "You have already liked this tweet." }, status: :unprocessable_entity
        else
          # Buat like baru
          like = @tweet.likes.new(user: current_user)
    
          if like.save
            render json: { message: "Tweet liked successfully." }, status: :ok
          else
            render json: { error: like.errors.full_messages }, status: :unprocessable_entity
          end
        end
    end
    
    def index
        likes = @tweet.likes
        render json: { likes: likes }
    end

    
    def destroy
        like = current_user.likes.find_by(tweet: @tweet)
    
        if like.destroy
        render json: { message: 'Like deleted successfully' }
        else
        render json: { message: 'Failed to delete like' }, status: :unprocessable_entity
        end
    end

    private

    def find_tweet
        @tweet = Tweet.find(params[:tweet_id])
    end


end
