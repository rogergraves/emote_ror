class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.text :source
      t.text :token
      t.datetime :purchase_date
      t.float :total_paid
      t.text :customer_name
      t.text :customer_id
      t.text :customer_address
      t.text :customer_email
      t.text :customer_phone
      t.text :description
      t.text :currency

      t.timestamps
    end
  end
end
