class AddFeedbackPromptToSurvey < ActiveRecord::Migration
  def self.up
    add_column :surveys, :feedback_prompt, :string, :default => ''
  end

  def self.down
    remove_column :surveys, :feedback_prompt
  end
end
