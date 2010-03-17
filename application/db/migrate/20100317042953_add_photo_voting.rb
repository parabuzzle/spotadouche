class AddPhotoVoting < ActiveRecord::Migration
  def self.up
    add_column "photos", "votesup", :int, :default => 0
    add_column "photos", "votesdown", :int, :default => 0
  end

  def self.down
    remove_column "photos", "votesup"
    remove_column "photos", "votesdown"
  end
end
