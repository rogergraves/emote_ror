class AddPartnercodeToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :partner_code, :string, :limit => 100
  end

  def self.down
    remove_column :users, :partner_code
  end
end
