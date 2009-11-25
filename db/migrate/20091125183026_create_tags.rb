class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.integer :group_id, :null => false
      t.integer :user_id, :null => false
      t.string  :name, :null => false
      t.boolean :is_income, :defaule => false
      t.integer :used_count, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end
