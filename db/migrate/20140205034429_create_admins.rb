class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.text :email
      t.text :encrypted_password
      t.text :password_salt
      t.text :reset_password_token
      t.text :remember_token
      t.text :remember_created_at
      t.integer :sign_in_count
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.text :current_sign_in_ip
      t.text :last_sign_in_ip

      t.timestamps
    end
  end
end
