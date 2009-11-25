# == Schema Information
#
# Table name: expenses
#
#  id          :integer         not null, primary key
#  group_id    :integer         not null
#  user_id     :integer         not null
#  tag_id      :integer
#  is_income   :boolean
#  amount      :float           not null
#  commit      :string(255)
#  charge_date :date
#  currency_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Expense < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  belongs_to :currency

  validates_numericality_of :amount, :greater_than => 0

  def charge_date
    self["charge_date"] || Date.today
  end
end
