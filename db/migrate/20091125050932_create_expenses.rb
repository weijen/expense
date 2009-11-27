class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.integer :group_id, :null => false
      t.integer :user_id, :null => false
      t.integer :tag_id, :null => false
      t.boolean :is_income, :default => false
      t.float :amount, :null => false
      t.string :note
      t.date :entry_date
      t.integer :currency_id

      t.timestamps
    end
    add_index :expenses, :group_id
    add_index :expenses, :user_id
    add_index :expenses, :tag_id
    add_index :expenses, :entry_date
    add_index :expenses, :currency_id
  end

  def self.down
    drop_table :expenses
  end
end
