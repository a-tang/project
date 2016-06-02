class AddCompanyPhoneNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company_phone_number, :string
  end
end
