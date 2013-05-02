class Job < ActiveRecord::Base
  attr_accessible :active, :address, :namecompany, :post
  belongs_to :user, class_name: "User"

  validates :user_id, presence: true
  validates :namecompany, presence: true
  validates :address, presence: true
  validates :post, presence: true

  default_scope order: 'jobs.created_at DESC'

end
