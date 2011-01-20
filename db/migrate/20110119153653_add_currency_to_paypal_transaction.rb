class AddCurrencyToPaypalTransaction < ActiveRecord::Migration
  def self.up
    add_column :paypal_transactions, :currency, :string, :default => 'USD'
  end

  def self.down
    remove_column :paypal_transactions, :currency
  end
end
