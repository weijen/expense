# == Schema Information
#
# Table name: currencies
#
#  id         :integer         not null, primary key
#  name       :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#

class Currency < ActiveRecord::Base
  has_many :expenses
end
