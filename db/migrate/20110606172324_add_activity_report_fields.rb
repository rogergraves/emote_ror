class AddActivityReportFields < ActiveRecord::Migration
  def self.up
    add_column :users, :activity_report_interval, :string, :limit => 15, :default => 'none'
    add_column :users, :activity_report_sent_at, :datetime, :default => Time.at(0).to_s(:db)
    add_column :surveys, :store_respondent_contacts, :boolean, :default => false
  end

  def self.down
    remove_columns :users, :activity_report_interval, :activity_report_sent_at
    remove_columns :surveys, :store_respondent_contacts, :activity_report_sent_at
  end
end
