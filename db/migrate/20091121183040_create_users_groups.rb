class CreateUsersGroups < ActiveRecord::Migration
  def self.up
    create_table :users_groups do |t|
      t.integer :user_id,   :null => false
      t.integer :group_id, :null => false
      t.boolean :proven,    :default => false
    end
    add_index :users_groups, :user_id
    add_index :users_groups, :group_id
  end

  def self.down
    drop_table :users_groups
  end
end
