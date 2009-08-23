class AddIsCurrentToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :is_current, :boolean, :default => false
    add_index :questions, :is_current
  end

  def self.down
    remove_index :questions, :is_current
    remove_column :questions, :is_current
  end
end
