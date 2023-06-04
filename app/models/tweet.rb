class Tweet < ApplicationRecord
    belongs_to :user
    belongs_to :original_tweet, class_name: 'Tweet', optional: true
    has_many :retweets, class_name: 'Tweet', foreign_key: 'original_tweet_id', dependent: :destroy
    has_many :likes
    has_many :comments
    has_many :images, as: :imgeable, dependent: :destroy
  
    validates :caption, presence: true

    accepts_nested_attributes_for :images, allow_destroy: true
    
    def retweet(user, caption)
        Tweet.create(caption: caption, user: user, original_tweet: self)
    end

    def add_comment(user, content)
      comments.create(user: user, content: content)
    end

    def retweeted?
        retweets.any?
    end
    
    def new_attribute
      {
        id: self.id,
        caption: self.caption,
        user_id: self.user_id,
        created_at: self.created_at,
        updated_at: self.updated_at,
        image: self.images.map(&:new_attribute)
      }
    end

    def retweet_attribute
        {
          id: self.id,
          caption: self.caption,
          user_id: self.user_id,
          original_tweet_id: self.original_tweet_id,
          retweets: self.retweets.map do |retweet|
            {
              id: retweet.id,
              caption: retweet.caption,
              user_id: retweet.user_id,
              original_tweet_id: retweet.original_tweet_id
            }
          end
        }
    end
end