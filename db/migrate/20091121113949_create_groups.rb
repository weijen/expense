class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.text :name
      t.text :short_name
      t.text :secret_id
      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
