class AddDurationToSubscription < ActiveRecord::Migration
  def self.up
    add_column :subscriptions, :start_date, :datetime, :null => false
    add_column :subscriptions, :end_date, :datetime, :null => false
    add_column :subscriptions, :kind, :integer, :default => 0, :null => false
    execute "UPDATE `subscriptions` SET `start_date`=`created_at`, `end_date`=DATE_ADD(`created_at`, INTERVAL 1 YEAR)"
  end

  def self.down
    remove_column :subscriptions, :start_date, :end_date, :kind
  end
end
