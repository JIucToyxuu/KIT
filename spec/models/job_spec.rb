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

require 'spec_helper'

describe Job do
  pending "add some examples to (or delete) #{__FILE__}"
end
