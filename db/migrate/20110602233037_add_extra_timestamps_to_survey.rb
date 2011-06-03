class AddExtraTimestampsToSurvey < ActiveRecord::Migration
  def self.up
    add_column :surveys, :activated_at, :datetime
    add_column :surveys, :scorecard_viewed_at, :datetime
    execute "UPDATE surveys SET activated_at = created_at, scorecard_viewed_at = created_at"
  end

  def self.down
    remove_columns :surveys, :activated_at, :scorecard_viewed_at
  end
end
