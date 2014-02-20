class Questions < ActiveRecord::Migration
  def change
    create_table :questions, :id => false, :primary_key => :id  do |t|
      t.string :id, null: false
      t.string :question
      t.string :answer
      t.string :reference_law
      t.string :excerpt_law
    end
  end
end
