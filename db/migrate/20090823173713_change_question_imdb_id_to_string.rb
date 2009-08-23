class ChangeQuestionImdbIdToString < ActiveRecord::Migration
  def self.up
    change_column :questions, :imdb_id, :string
  end

  def self.down
    change_column :questions, :imdb_id, :int
  end
end
