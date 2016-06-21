class AddCategoryIdToContests < ActiveRecord::Migration
  def change
    add_reference :contests, :category, index: true, foreign_key: true
  end
end
