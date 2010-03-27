class CreateBadges < ActiveRecord::Migration
  def self.up
    create_table :badges do |t|
      t.column :user_id, :int
      t.column :profile, :boolean, :default => false
      t.column :first_photo, :boolean, :default => false
      t.column :iphone, :boolean, :default => false
      t.column :facebook, :boolean, :default => false
      t.column :rated, :boolean, :default => false
      t.column :dond, :boolean, :default => false
      t.column :survey, :boolean, :default => false
      t.column :comment, :boolean, :default => false
      t.column :avatar, :boolean, :defatult => false
      t.timestamps
    end
  end

  def self.down
    drop_table :badges
  end
end
