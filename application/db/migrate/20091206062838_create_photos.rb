class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.column :user_id, :int
      t.column :size, :int
      t.column :content_type, :string
      t.column :filename, :string
      t.column :height, :int
      t.column :width, :int
      t.column :parent_id, :int
      t.column :thumbnail, :string
      t.column :status, :int, :default => 0
      t.column :title, :string
      t.column :description, :text
      t.column :rating_type_id, :int
      t.column :admin_notes, :string
      t.column :anony, :boolean, :default => false
      t.column :location, :string, :default => "Unknown"
      t.column :ip, :string
      t.column :source, :string, :default => 'Web'
      t.column :terms_acceptence, :boolean, :default => false
      Photo.generate_ratings_columns t
      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
