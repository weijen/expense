class AddColumnsToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :state, :string, :default => "alive"
    add_column :groups, :froze_before_date, :date
    add_column :groups, :url, :string
    add_column :groups, :description, :text
  end

  def self.down
    remove_column :groups, :state
    remove_column :groups, :froze_before_date
    remove_column :groups, :url
    remove_column :groups, :description
  end
end
