class AddBannedToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :banned, :boolean, :default => false
  end

  def self.down
    remove_column :users, :banned
  end
end
