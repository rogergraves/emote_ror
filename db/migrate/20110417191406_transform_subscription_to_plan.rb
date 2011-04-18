class TransformSubscriptionToPlan < ActiveRecord::Migration
  
  def self.up
    rename_column :subscriptions, :kind, :old_kind
    add_column :subscriptions, :kind, :string, :null => false, :limit => 20

    Subscription.reset_column_information

    subscriptions = select_all(
      <<-SQL
        SELECT user_id, SUM(emote_amount) AS emote_amount, 
            MIN(start_date) AS start_date, MAX(end_date) AS end_date,
            MIN(created_at) AS created_at, MAX(updated_at) AS updated_at
          FROM subscriptions
          WHERE old_kind = 0 AND token <> 'FREE TRIAL'
          GROUP BY user_id 
      SQL
    )
    subscriptions.each{ |s| s.symbolize_keys! }
    execute "DELETE FROM subscriptions"
    
    User.all.each do |user|
      plan = Subscription.new
      if plan_data = subscriptions.select{|s| s[:user_id] == user.id.to_s }.first
        plan.attributes = plan_data
        plan.kind = case plan.emote_amount
          when 2 then 'start'
          when 10 then 'expand'
          when 25 then 'magnify'
          else 'custom'
        end
      else
        plan.user_id = user.id
        plan.kind = 'free'
        plan.start_date = user.created_at
        plan.end_date = 1.year.since(plan.start_date)
        plan.emote_amount = 1
      end
      plan.save
    end
    
    remove_column :subscriptions, :old_kind, :token, :purchase_date, :total_paid, :customer_name,
      :customer_id, :customer_address, :customer_email, :customer_phone, :description,
      :product_code, :currency
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end

end
