class MergeSubscriptionsPaypalTransactions < ActiveRecord::Migration
  def self.up
    add_column :subscriptions, :token, :string
    add_column :subscriptions, :purchase_date, :datetime
    add_column :subscriptions, :total_paid, :float, :null => false, :default => 0.0
    add_column :subscriptions, :customer_name, :string
    add_column :subscriptions, :customer_id, :string, :limit => 32
    add_column :subscriptions, :customer_address, :string
    add_column :subscriptions, :customer_email, :string
    add_column :subscriptions, :customer_phone, :string, :limit => 50
    add_column :subscriptions, :description, :string
    add_column :subscriptions, :product_code, :string, :default => nil, :limit => 64
    add_column :subscriptions, :currency, :string, :default => 'USD', :limit => 10

    execute "UPDATE subscriptions SET kind = 0 WHERE kind = 1 AND emote_amount > 1 "
    
    execute <<-SQL
      UPDATE
        subscriptions AS s, paypal_transactions AS p
      SET
        s.token = p.token, s.purchase_date = STR_TO_DATE(p.date, '%Y-%m-%d %H:%i:%s'),
        s.total_paid = CAST(p.total AS DECIMAL), s.customer_name = p.customer_name,
        s.customer_id = p.customer_id, s.customer_address = p.customer_address,
        s.customer_email = p.customer_email, s.customer_phone = p.customer_phone,
        s.description = p.description, s.product_code = p.product_code, s.currency = p.currency
      WHERE
        s.id = p.subscription_id AND s.kind = 0
    SQL

    execute <<-SQL
      UPDATE
        subscriptions
      SET
        token = 'FREE TRIAL',
        total_paid = 0,
        description = '1 emote'
      WHERE
        kind = 1 AND emote_amount = 1
    SQL

    execute "UPDATE subscriptions SET purchase_date = created_at WHERE purchase_date IS NULL"
    
    drop_table :paypal_transactions
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end

end
