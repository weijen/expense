class CreateCurrencies < ActiveRecord::Migration
  def self.up
    create_table :currencies do |t|
      t.string :name, :null => false

      t.timestamps
    end

    Currency.create!(:name => "TWD")
  end

  def self.down
    drop_table :currencies
  end
end
