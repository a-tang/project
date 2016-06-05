class RemoveImagesFromContests < ActiveRecord::Migration
  def change
    remove_column :contests, :images, :json
  end
end
