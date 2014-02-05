class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
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
      t.text :full_name
      t.text :country_code
      t.text :company
      t.text :job_title
      t.text :phone_number
      t.text :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.integer :banned
      t.integer :surveys_count
      t.integer :subscriptions_count
      t.text :activity_report_interval
      t.datetime :activity_report_sent_at
      t.text :partner_code

      t.timestamps
    end
  end
end
