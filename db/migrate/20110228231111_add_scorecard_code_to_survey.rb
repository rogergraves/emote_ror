class AddScorecardCodeToSurvey < ActiveRecord::Migration
  def self.up
    add_column :surveys, :scorecard_code, :string, :null => false, :limit => 20
    execute "UPDATE `surveys` SET `scorecard_code`=CRC32(`id`)"
    add_index :surveys, :scorecard_code, :unique => true
  end

  def self.down
    remove_index :surveys, :scorecard_code
    remove_column :surveys, :scorecard_code
  end
end
