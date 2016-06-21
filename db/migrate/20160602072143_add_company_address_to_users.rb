class AddCompanyAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company_address, :string
  end
end
