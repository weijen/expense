class CreateExpenses < ActiveRecord::Migration
  def self.up
    create_table :expenses do |t|
      t.integer :group_id, :null => false
      t.integer :user_id, :null => false
      t.integer :tag_id
      t.boolean :is_income, :default => false
      t.float :amount, :null => false
      t.string :comment
      t.date :charge_date
      t.integer :currency_id

      t.timestamps
    end
  end

  def self.down
    drop_table :expenses
  end
end
