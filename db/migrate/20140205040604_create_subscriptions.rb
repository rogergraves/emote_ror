class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :emote_amount
      t.datetime :start_date
      t.datetime :end_date
      t.text :kind

      t.timestamps
    end
  end
end
