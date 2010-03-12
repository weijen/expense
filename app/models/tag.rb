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
  has_many :expenses

  named_scope :income, :conditions => ["is_income = ?", true]
  named_scope :outgoing, :conditions => ["is_income = ?", false]
  named_scope :sort_by_counter, :order => "counter DESC"

  def <=>(other_tag)
    self.counter <=> other_tag.counter
  end

  # Tags priority is 1. I even used 2. Groups even used 3. other
  def self.get_sorted_tags(user, kind = "outgoing")
    if kind == "income"
      my_tags = user.expenses.income.map{ |expense| expense.tag }.uniq.sort
      groups_tags = user.groups.approved_groups.map{ |group| group.tags.income }.flatten.uniq.sort
      all_tags = Tag.income.sort
    else
      my_tags = user.expenses.outgoing.map{ |expense| expense.tag }.uniq.sort
      groups_tags = user.groups.approved_groups.map{ |group| group.tags.outgoing }.flatten.uniq.sort
      all_tags = Tag.outgoing.sort
    end
    return [my_tags, groups_tags, all_tags].flatten.uniq
  end
end
