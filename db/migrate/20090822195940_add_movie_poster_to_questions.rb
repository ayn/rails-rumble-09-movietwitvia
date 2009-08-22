class AddMoviePosterToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :movie_poster, :string
  end

  def self.down
    remove_column :questions, :movie_poster
  end
end
