class AddImagesToContests < ActiveRecord::Migration
  def change
    add_column :contests, :images, :json
  end
end
