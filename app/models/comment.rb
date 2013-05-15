class Comment < ActiveRecord::Base
  attr_accessible :text_of_comment, :id_message, :id_user
  belongs_to :micropost
  belongs_to :user

  validates :id_user, presence: true
  validates :id_message, presence: true
  validates :text_of_comment, presence: true, length: { maximum: 140 }

  default_scope order: 'comments.created_at DESC'
end
