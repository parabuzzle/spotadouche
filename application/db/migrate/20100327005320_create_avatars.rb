class CreateAvatars < ActiveRecord::Migration
  def self.up
    create_table :avatars do |t|
      t.column :user_id, :int
      t.column :size, :int
      t.column :content_type, :string
      t.column :filename, :string
      t.column :height, :int
      t.column :width, :int
      t.column :parent_id, :int
      t.column :thumbnail, :string
      t.column :status, :int, :default => 0
      t.column :ip, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :avatars
  end
end
