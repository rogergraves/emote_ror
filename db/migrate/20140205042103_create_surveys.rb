class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.integer :user_id
      t.text :project_name
      t.float :score
      t.integer :response_count
      t.integer :public
      t.text :code
      t.text :action_token
      t.integer :state
      t.text :scorecard_code
      t.datetime :activated_at
      t.datetime :scorecard_viewed_at
      t.integer :store_respondent_contracts
      t.text :feedback_prompt

      t.timestamps
    end
  end
end
