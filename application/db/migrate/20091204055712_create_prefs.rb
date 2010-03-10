class CreatePrefs < ActiveRecord::Migration
  def self.up
    create_table :prefs do |t|
      t.column :user_id, :int
      t.column :default_annonimize, :boolean, :default => false
      t.column :daily_douche, :boolean, :default => true
      t.column :about, :text
      t.column :auto_post_fb_feed, :boolean, :default => false
      t.column :submission_email, :string
      t.column :twitter, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :prefs
  end
end
