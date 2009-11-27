# == Schema Information
#
# Table name: tag_group_relations
#
#  id         :integer         not null, primary key
#  tag_id     :integer
#  group_id   :integer
#  counter    :integer
#  created_at :datetime
#  updated_at :datetime
#

class TagGroupRelation < ActiveRecord::Base
  belongs_to :tag
  belongs_to :group
end
