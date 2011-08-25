class AddEmailUsedToSurveyResults < ActiveRecord::Migration
  def self.up
    add_column :survey_result, :email_used, :boolean, :default => false
  end

  def self.down
    remove_column :survey_result, :email_used
  end
end
