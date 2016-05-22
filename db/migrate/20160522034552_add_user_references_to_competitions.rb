class AddUserReferencesToCompetitions < ActiveRecord::Migration
  def change
    add_reference :competitions, :user, index: true, foreign_key: true
  end
end
