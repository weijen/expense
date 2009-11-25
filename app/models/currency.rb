class Currency < ActiveRecord::Base
  has_many :expenses
end
