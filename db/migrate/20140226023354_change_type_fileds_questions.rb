class ChangeTypeFiledsQuestions < ActiveRecord::Migration
  def change
    change_column :questions, :id, :string, :limit => 25
    change_column :questions, :question, :text
    change_column :questions, :answer, :text
    change_column :questions, :reference_law, :text
    change_column :questions, :excerpt_law, :text
  end
end
