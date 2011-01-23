class AddProductCodeToPaypalTransaction < ActiveRecord::Migration
  def self.up
    add_column :paypal_transactions, :product_code, :string, :default => nil
  end

  def self.down
    remove_column :paypal_transactions, :product_code
  end
end
