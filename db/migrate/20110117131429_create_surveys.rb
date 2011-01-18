class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_table :surveys do |t|
      t.integer :user_id
      t.string :project_name, :null => false
      t.float :score, :default => 0
      t.integer :responses_count, :default => 0
      t.boolean :active, :default => false
      t.boolean :public, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :surveys
  end
end
