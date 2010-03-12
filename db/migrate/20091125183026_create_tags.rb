class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.integer :user_id, :null => false
      t.string  :name, :null => false
      t.boolean :is_income, :default => false
      t.integer :counter, :default => 0
      t.timestamps
    end
    add_index :tags, :name
    add_index :tags, :counter
  end

  def self.down
    drop_table :tags
  end
end
