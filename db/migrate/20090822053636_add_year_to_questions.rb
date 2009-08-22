class AddYearToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :year, :integer
  end

  def self.down
    remove_column :questions, :year
  end
end
