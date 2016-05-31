class AddUserIdToContests < ActiveRecord::Migration
  def change
    add_reference :contests, :user, index: true, foreign_key: true
  end
end
