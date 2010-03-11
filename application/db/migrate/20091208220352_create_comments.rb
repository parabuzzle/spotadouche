class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :photo_id, :int
      t.column :user_id, :int
      t.column :data, :text
      t.column :ip, :string
      t.column :deleted, :boolean, :default => false
      t.column :spam_score, :int
      t.column :nspam, :boolean, :default => false
      t.column :source, :string, :default => 'Web'
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
