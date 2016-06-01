class AddContestIdToUserImages < ActiveRecord::Migration
  def change
    add_reference :user_images, :contest, index: true, foreign_key: true
  end
end
