# coding: utf-8
# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#  family_name     :string(255)
#  patronymic      :string(255)
#  faculty         :string(255)
#  chair           :string(255)
#  branch          :string(255)
#  year_off        :integer
#
# coding: utf-8

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, 
          :family_name, :patronymic, :faculty, :chair, :branch, :year_off
  has_secure_password

  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :jobs, foreign_key: "user_id", dependent: :destroy


  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                        format: { with: VALID_EMAIL_REGEX },
			uniqueness: { case_sensitive: false }  
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :family_name, presence: true
  validates :patronymic, presence: true
  validates :faculty, presence: true
  validates :chair, presence: true
  validates :branch, presence: true
  validates :year_off, presence: true

  def feed
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end





  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
