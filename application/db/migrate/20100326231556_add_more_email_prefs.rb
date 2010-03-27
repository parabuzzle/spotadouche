class AddMoreEmailPrefs < ActiveRecord::Migration
  def self.up
    add_column "prefs", "system_mail", :boolean, :default => true
    add_column "prefs", "comments_mail", :boolean, :default => true
    add_column "prefs", "updates_mail", :boolean, :default => true
  end

  def self.down
    remove_column "prefs", "system_mail"
    remove_column "prefs", "comments_mail"
    remove_column "prefs", "updates_mail"
  end
end
