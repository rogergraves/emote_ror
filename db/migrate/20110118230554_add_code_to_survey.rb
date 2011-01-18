class AddCodeToSurvey < ActiveRecord::Migration
  def self.up
    add_column :surveys, :code, :string, :null => false, :limit => 20
    execute "UPDATE `surveys` SET `code`=CRC32(`id`)"
    add_index :surveys, :code, :unique => true
  end

  def self.down
    remove_column :surveys, :code
    remove_index :surveys, :code
  end
end
