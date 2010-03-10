class AddRatingTable < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.column(:rater_id,   :integer)
      t.column :rated_id,   :integer
      t.column :rated_type, :string
      t.column :rating,     :decimal
      t.add_index :rater_id
      t.add_index [:rated_type, :rated_id]
      t.timestamps
    end
    create_table :rating_statistics do |t|
      t.column :rated_id, :integer
      t.column :rated_type, :string
      t.column :rating_count, :integer
      t.column :rating_total, :decimal
      t.column :rating_avg, :decimal, :precision => 10, :scale => 2
      t.add_index [:rated_type, :rated_id]
    end
  end

  def self.down
    drop_table :ratings
    drop_table :rating_statistics
  end
end
