class CreateCurrencies < ActiveRecord::Migration
  def self.up
    create_table :currencies do |t|
      t.string :name, :null => false

      t.timestamps
    end
    add_index :currencies, :name
  end

  def self.down
    drop_table :currencies
  end
end
