class CreateSurveyResults < ActiveRecord::Migration
  def change
    create_table :survey_results do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.text :ip
      t.text :emote
      t.integer :intensity_level
      t.string :verbatim
      t.text :code
      t.integer :is_removed
      t.text :email
      t.integer :email_used

      t.timestamps
    end
  end
end
