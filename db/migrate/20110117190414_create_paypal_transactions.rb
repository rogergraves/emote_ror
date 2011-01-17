class CreatePaypalTransactions < ActiveRecord::Migration
  def self.up
    create_table :paypal_transactions do |t|
      t.belongs_to  :user
      t.belongs_to  :subscription
      t.string      :token
      t.string      :date
      t.string      :total
      t.string      :customer_name
      t.string      :customer_id
      t.string      :customer_address
      t.string      :customer_email
      t.string      :customer_phone
      t.string      :description
    end
  end

  def self.down
    drop_table :paypal_transactions
  end
end
