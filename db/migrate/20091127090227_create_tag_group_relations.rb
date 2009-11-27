class CreateTagGroupRelations < ActiveRecord::Migration
  def self.up
    create_table :tag_group_relations do |t|
      t.integer :tag_id
      t.integer :group_id
      t.integer :counter

      t.timestamps
    end
  end

  def self.down
    drop_table :tag_group_relations
  end
end
