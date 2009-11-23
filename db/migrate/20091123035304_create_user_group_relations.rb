class CreateUserGroupRelations < ActiveRecord::Migration
  def self.up
    create_table :user_group_relations do |t|
      t.integer :user_id, :null => false
      t.integer :group_id, :null => false
      t.boolean :proven, :default => false

      t.timestamps
    end
    add_index :user_group_relations, :user_id
    add_index :user_group_relations, :group_id
  end

  def self.down
    drop_table :user_group_relations
  end
end
