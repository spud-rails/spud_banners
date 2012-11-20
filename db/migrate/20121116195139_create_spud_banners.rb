class CreateSpudBanners < ActiveRecord::Migration
  def change
    create_table :spud_banners do |t|
      t.integer :spud_banner_set_id, :null => false
      t.string :link_to
      t.string :link_to_class
      t.string :target
      t.integer :order, :default => 0
      t.attachment :banner
      t.timestamps
    end
    add_index :spud_banners, :spud_banner_set_id, :unique => false
  end
end
