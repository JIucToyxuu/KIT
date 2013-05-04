# == Schema Information
#
# Table name: chairs
#
#  id         :integer          not null, primary key
#  namechair  :string(255)
#  faculty_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Chair < ActiveRecord::Base
  attr_accessible :faculty_id, :namechair
  belongs_to :faculty
  has_many :branchs, dependent: :destroy

  validates :namechair, presence: true, uniqueness: true
  validates :faculty_id, presence: true

  default_scope order: 'chairs.created_at DESC'
end
