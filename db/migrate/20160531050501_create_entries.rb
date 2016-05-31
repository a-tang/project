class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :contest, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :entered, default: false

      t.timestamps null: false
    end
  end
end
