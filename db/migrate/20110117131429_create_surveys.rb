class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_table :surveys do |t|
      t.integer :user_id
      t.string :project_name
      t.float :score
      t.integer :responses_count
      t.boolean :active
      t.boolean :public

      t.timestamps
    end
  end

  def self.down
    drop_table :surveys
  end
end
