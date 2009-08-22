class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.integer :imdb_id
      t.string :title
      t.string :actors
      t.string :tweet_id
      t.integer :winner_id
      t.timestamps
    end
    
    add_index :questions, :imdb_id
    add_index :questions, :updated_at
    add_index :questions, :tweet_id
  end

  def self.down
    drop_table :questions
  end
end
