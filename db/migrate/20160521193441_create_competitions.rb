class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :title
      t.text :body
      t.string :prize
      t.datetime :end_date
      t.integer :number_of_entries
      t.integer :number_of_views

      t.timestamps null: false
    end
  end
end
