# == Schema Information
#
# Table name: faculties
#
#  id          :integer          not null, primary key
#  namefaculty :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Faculty < ActiveRecord::Base
  attr_accessible :namefaculty
  has_many :chairs, dependent: :destroy

  validates :namefaculty, presence: true, uniqueness: true

  default_scope order: 'faculties.created_at DESC'
end
