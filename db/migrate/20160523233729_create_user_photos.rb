class CreateUserPhotos < ActiveRecord::Migration
  def change
    create_table :user_photos do |t|
      t.string :photo
      t.references :competition, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
