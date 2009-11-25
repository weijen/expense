class CreateCurrencies < ActiveRecord::Migration
  def self.up
    create_table :currencies do |t|
      t.string :name, :null => false

      t.timestamps
    end

    Currency.create!(:name => "TWD")
    Currency.create!(:name => "USD")
    Currency.create!(:name => "EUR")
    Currency.create!(:name => "CNY")
    Currency.create!(:name => "JPY")
    Currency.create!(:name => "HKD")
  end

  def self.down
    drop_table :currencies
  end
end
