class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.integer :group_id
      t.integer :user_id
      t.string :name
      t.boolean :is_income

      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end
