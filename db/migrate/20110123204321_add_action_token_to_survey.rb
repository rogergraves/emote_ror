class AddActionTokenToSurvey < ActiveRecord::Migration
  def self.up
    add_column :surveys, :action_token, :string, :default => nil
  end

  def self.down
    remove_column :surveys, :action_token
  end
end
