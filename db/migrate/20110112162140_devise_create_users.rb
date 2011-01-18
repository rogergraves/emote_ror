class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.string    :first_name, :limit => 60
      t.string    :last_name, :limit => 60
      t.string    :country_code, :limit => 20
      t.string    :company, :limit => 60
      t.string    :job_title, :limit => 60
      t.string    :phone_number, :limit => 25
      t.string    :cell_number, :limit => 25

      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :users
  end
end
