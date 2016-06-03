class AddPublishedToContests < ActiveRecord::Migration
  def change
    add_column :contests, :published, :boolean, default: false
  end
end
