class AddBouncingFlagAndPoints < ActiveRecord::Migration
  def self.up
    add_column "users", "bouncing", :boolean, :default => false
    add_column "users", "score", :int, :default => 0
  end

  def self.down
    remove_column "users", "bouncing"
    remove_column "users", "score"
  end
end
