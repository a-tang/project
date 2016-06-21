class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :title
      t.text :body
      t.string :prize
      t.datetime :end_date
      t.boolean :featured, default: false
      t.string :image

      t.timestamps null: false
    end
  end
end
