class CreateSurveyDemoResults < ActiveRecord::Migration
  def change
    create_table :survey_demo_results do |t|
      t.integer :survey_result_id
      t.text :question
      t.string :answer
      t.text :question_field

      t.timestamps
    end
  end
end
