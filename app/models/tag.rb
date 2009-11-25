# == Schema Information
#
# Table name: tags
#
#  id         :integer         not null, primary key
#  group_id   :integer         not null
#  user_id    :integer         not null
#  name       :string(255)     not null
#  is_income  :boolean
#  used_count :integer         default(0)
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
end
