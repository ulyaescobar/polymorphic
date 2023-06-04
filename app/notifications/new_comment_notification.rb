class NewCommentNotification < Noticed::Base
  deliver_by :database

  # Menambahkan initialize method untuk menerima komentar dan tweet sebagai argumen
  def initialize(comment, tweet)
    @comment = comment
    @tweet = tweet
  end

  def to_database
    # Menggunakan instance variable @comment dan @tweet yang sudah diinisialisasi
    {
      comment_id: @comment.id,
      user_id: @comment.user.id,
      tweet_id: @tweet.id
    }
  end

  def message
    "You have a new comment on your tweet"
  end

  def url
    "/tweets/#{@tweet.id}"
  end
end