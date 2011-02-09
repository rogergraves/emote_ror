class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.integer :creator_id, :null => false
      t.integer :subject_id
      t.string :creator_type, :limit => 30, :null => false
      t.string :subject_type, :limit => 30
      t.text :text
      t.boolean :archived, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :notes
  end
end
