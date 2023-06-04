# app/models/user.rb
require 'bcrypt'

class User < ApplicationRecord
  # has_many :projects
  has_many :tweets
  has_many :likes
  has_many :comments
  has_many :points
  has_many :notifications, foreign_key: :recipient_id, dependent: :destroy
  has_one :avatar, as: :imgeable, class_name: "Image"
  
  has_secure_password

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }

  after_create :create_avatar

  def create_avatar
    self.build_avatar.save
  end

  def new_attribute
    {
      id: self.id,
      email: self.email,
      password: self.password,
      avatar: self.avatar&.new_attribute
    }
  end
end