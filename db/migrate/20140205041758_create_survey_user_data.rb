class CreateSurveyUserData < ActiveRecord::Migration
  def change
    create_table :survey_user_data do |t|
      t.integer :survey_result_id
      t.text :name
      t.text :email
      t.text :phone

      t.timestamps
    end
  end
end
