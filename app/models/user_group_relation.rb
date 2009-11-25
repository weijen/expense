# == Schema Information
#
# Table name: user_group_relations
#
#  id         :integer         not null, primary key
#  user_id    :integer         not null
#  group_id   :integer         not null
#  proven     :boolean
#  manager    :boolean
#  created_at :datetime
#  updated_at :datetime
#

class UserGroupRelation < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
end
