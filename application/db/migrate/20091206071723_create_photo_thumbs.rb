class CreatePhotoThumbs < ActiveRecord::Migration
  def self.up
    create_table :photo_thumbs do |t|
      t.column :size, :int
      t.column :content_type, :string
      t.column :filename, :string
      t.column :height, :int
      t.column :width, :int
      t.column :parent_id, :int
      t.column :thumbnail, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :photo_thumbs
  end
end
