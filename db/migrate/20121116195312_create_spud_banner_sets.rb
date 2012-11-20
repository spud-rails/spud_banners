class CreateSpudBannerSets < ActiveRecord::Migration
  def change
    create_table :spud_banner_sets do |t|
      t.string :name, :null => false
      t.integer :width, :null => false
      t.integer :height, :null => false
      t.boolean :cropped, :default => true
      t.timestamps
    end
    add_index :spud_banner_sets, :name, :unique => true
  end
end
