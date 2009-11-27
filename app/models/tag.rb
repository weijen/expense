# == Schema Information
#
# Table name: tags
#
#  id         :integer         not null, primary key
#  user_id    :integer         not null
#  name       :string(255)     not null
#  is_income  :boolean
#  counter    :integer         default(0)
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base
  belongs_to :user
  has_many :tag_group_relations
  has_many :groups, :through => :tag_group_relations

  named_scope :income, :conditions => ["is_income = ?", true]
  named_scope :outgoing, :conditions => ["is_income = ?", false]
end
