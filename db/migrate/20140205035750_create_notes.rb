class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :creator_id
      t.integer :subject_id
      t.text :creator_type
      t.text :subject_type
      t.string :text
      t.integer :archived

      t.timestamps
    end
  end
end
