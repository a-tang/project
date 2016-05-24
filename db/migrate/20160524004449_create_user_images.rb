class CreateUserImages < ActiveRecord::Migration
  def change
    create_table :user_images do |t|
      t.string :image
      t.references :competition, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
