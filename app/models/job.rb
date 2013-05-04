# == Schema Information
#
# Table name: jobs
#
#  id          :integer          not null, primary key
#  namecompany :string(255)
#  address     :string(255)
#  post        :string(255)
#  active      :boolean
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Job < ActiveRecord::Base
  attr_accessible :active, :address, :namecompany, :post
  belongs_to :user, class_name: "User"

  validates :user_id, presence: true
  validates :namecompany, presence: true
  validates :address, presence: true
  validates :post, presence: true

  default_scope order: 'jobs.created_at DESC'

end
