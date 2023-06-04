class AddOriginalTweetToTweets < ActiveRecord::Migration[7.0]
  def change
    add_reference :tweets, :original_tweet, foreign_key: { to_table: :tweets }
  end
end
