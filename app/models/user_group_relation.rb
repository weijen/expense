class UserGroupRelation < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
end

# == Schema Information
#
# Table name: user_group_relations
#
#  id         :integer         not null, primary key
#  user_id    :integer         not null
#  group_id   :integer         not null
#  approved   :boolean         default(FALSE)
#  manager    :boolean         default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

