class AddCountersToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :surveys_count, :integer, :default => 0
    add_column :users, :subscriptions_count, :integer, :default => 0
    
    User.reset_column_information
    User.all.each do |u|
      User.reset_counters u.id, :surveys
      User.reset_counters u.id, :subscriptions
    end
  end

  def self.down
    remove_column :users, :surveys_count, :subscriptions_count
  end
end
