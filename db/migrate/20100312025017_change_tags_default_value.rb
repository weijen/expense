class ChangeTagsDefaultValue < ActiveRecord::Migration
  def self.up
    change_column_default :tags, :is_income, "f" 
  end

  def self.down
  end
end
