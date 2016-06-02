class AddCompanyWebsiteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company_website, :string
  end
end
