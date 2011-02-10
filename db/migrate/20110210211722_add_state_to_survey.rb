class AddStateToSurvey < ActiveRecord::Migration
  def self.up
    add_column :surveys, :state, :integer, :default => 0, :null => false
    execute "UPDATE `surveys` SET `state`=1 WHERE `active`=0"
    remove_column :surveys, :active
  end

  def self.down
    add_column :surveys, :active, :boolean, :default => false
    execute "UPDATE `surveys` SET `active`=1 WHERE `state`=0"
    remove_column :surveys, :state
  end
end
