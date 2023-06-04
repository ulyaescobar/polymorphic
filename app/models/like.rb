class Like < ApplicationRecord

  belongs_to :user
  belongs_to :tweet

  after_create :create_like_notification

  def create_like_notification
    recipient = self.tweet.user
    actor = self.user
    notifiable = self

    recipient.notifications.create(
      actor: actor,
      notifiable: notifiable,
      action: 'liked'
    )
  end
end
