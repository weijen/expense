# == Schema Information
#
# Table name: expenses
#
#  id          :integer         not null, primary key
#  group_id    :integer         not null
#  user_id     :integer         not null
#  tag_id      :integer         not null
#  is_income   :boolean
#  amount      :float           not null
#  note        :string(255)
#  entry_date  :date
#  currency_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Expense < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  belongs_to :tag
  belongs_to :currency

  validates_numericality_of :amount, :greater_than => 0
  validates_presence_of :tag_id, :group_id, :user_id

  named_scope :income, :conditions => { :is_income => true }
  named_scope :outgoing, :conditions => { :is_income => false }
  named_scope :by_user, lambda { |user| {:conditions => ["user_id = ?", user.id]} }
  named_scope :by_tag, lambda { |tag| {:conditions => ["tag_id = ?", tag.id]} }
  named_scope :by_group, lambda { |group| {:conditions => ["group_id = ?", group.id]} }

 

  before_save :set_is_income, :increment_tag_used_count
  def charge_date
    self["charge_date"] || Date.today
  end

  def self.total
    self.income.sum(:amount) - self.outgoing.sum(:amount) 
  end

  def set_is_income
    self.is_income = self.tag.is_income
    true
  end

  def increment_tag_used_count
    self.tag.counter += 1
    self.tag.save!
  end

  def show_amount
    "#{(is_income ? "" : "-")}#{amount}" 
  end
end
