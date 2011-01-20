class UpdateUserFields < ActiveRecord::Migration

  def self.up
    remove_column :users, :last_name, :cell_number
    rename_column :users, :first_name, :full_name
    change_column :users, :full_name, :string, :limit => 100
    
    add_index :users, :confirmation_token, :unique => true #Had to do it in 20110119020010_devise_user_confirmable, but forgot :(
  end

  def self.down
    add_column :users, :last_name, :string, :limit => 60
    add_column :users, :cell_number, :string, :limit => 25
    rename_column :users, :name, :first_name

    remove_index :users, :confirmation_token
  end
end
