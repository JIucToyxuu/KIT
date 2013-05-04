# == Schema Information
#
# Table name: branches
#
#  id         :integer          not null, primary key
#  namebranch :string(255)
#  chair_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Branch < ActiveRecord::Base
  attr_accessible :chair_id, :namebranch
  belongs_to :chair

  validates :namebranch, presence: true, uniqueness: true
  validates :chair_id, presence: true

  default_scope order: 'branches.created_at DESC'
end
