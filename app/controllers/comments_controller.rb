class CommentsController < ApplicationController
    before_action :find_tweet

    def index
        @comments = @tweet.comments
        render json: {
            status: 200,
            message: "this all comments by tweet id #{params[:tweet_id]}",
            data: {
                comments: @comments
            }
        }, status: :ok
    end

    def create
        @comment = @tweet.comments.build(comment_params)
        @comment.user = current_user
  
        if @comment.save
          render json: {
            status: 201,
            message: "comment has been send",
            data: {
                comment: @comment
            }
          }, status: :created
        else
          render json: { error: 'Failed to create comment' }, status: :unprocessable_entity
        end
    end

    def update
        @comment = @tweet.comments.find(params[:id])
        if @comment.update(comment_params)
            render json: {
                status: 200,
                message: "comment has been updated",
                data: {
                    comment: @comment
                }
            }, status: :ok
        else
            render json: {
                status: 422,
                message: "comment update failed"
            }, status: :unprocessable_entity
        end
    end

    def destroy
        @comment = @tweet.comments.find(params[:id])
        if @comment.destroy
            render json: {
                status: 200,
                message: "deleted comment with id #{params[:id]} succes"
            }, status: :ok
        else
            render json: {
                status: 422,
                message: "delete failesd"
            }, status: :unprocessable_entity
        end

    end

    def count_comment
        @comments = @tweet.comments.count
        render json: {
            status: 200,
            message: "count the comment is #{@comments}"
        }, status: :ok
    end
  
    private

    def find_tweet
        @tweet = Tweet.find(params[:tweet_id])
    end
  
    def comment_params
        params.permit(:body)
    end
end
