class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.boolean :admin, default: false
      t.boolean :activated, default: false
      t.string :account_verification_token
      t.datetime :account_verification_requested_at
      t.string :password_reset_token
      t.datetime :password_reset_requested_at

      t.timestamps null: false
    end
  end
end
