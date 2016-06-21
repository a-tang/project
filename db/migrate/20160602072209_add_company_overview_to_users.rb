class AddCompanyOverviewToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company_overview, :text
  end
end
