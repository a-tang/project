class AddFeaturedToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :featured, :boolean, default: false
  end
end
