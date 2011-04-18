class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.belongs_to :user
      t.string     :source, :null => false #paypal / offline / ...
      t.string     :token
      t.datetime   :purchase_date
      t.float      :total_paid, :null => false, :default => 0.0
      t.string     :customer_name
      t.string     :customer_id, :limit => 64
      t.string     :customer_address
      t.string     :customer_email
      t.string     :customer_phone, :limit => 50
      t.string     :description
      t.string     :currency, :default => 'USD', :limit => 10
      t.timestamps
    end

    execute <<-SQL
      INSERT INTO payments (user_id, source, token, purchase_date, total_paid, customer_name,
                customer_id, customer_address, customer_email, customer_phone, description, currency,
                created_at, updated_at)
        SELECT user_id, IF((token LIKE 'EC-%'), 'paypal', 'offline'), token, purchase_date, total_paid, customer_name,
                customer_id, customer_address, customer_email, customer_phone, description, currency,
                created_at, updated_at
          FROM subscriptions WHERE kind = 0 AND total_paid > 0;
    SQL

  end

  def self.down
    drop_table :payments
  end
end
