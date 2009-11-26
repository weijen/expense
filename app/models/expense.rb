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
#  comment     :string(255)
#  charge_date :date
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

  named_scope :income, :conditions => { :is_income => true }
  named_scope :outgoing, :conditions => { :is_income => false } 

  before_save :set_is_income
  def charge_date
    self["charge_date"] || Date.today
  end

  def self.total
    self.income.sum(:amount) - self.outgoing.sum(:amount) 
  end

  def set_is_income
    unless self.tag_id
      self.errors.add(:tag_id, "can't be blank")
      return false
    end
    self.is_income = self.tag.is_income
    return true
  end
end
