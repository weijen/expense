class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name
      t.string :short_name
      t.string :secret_id
      t.integer :owner_id
      t.timestamps
    end
    add_index :groups, :name
    add_index :groups, :short_name
    add_index :groups, :secret_id
    add_index :groups, :owner_id
  end

  def self.down
    drop_table :groups
  end
end
