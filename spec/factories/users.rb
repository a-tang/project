FactoryGirl.define do
  factory :user do
    first_name "MyString"
    last_name "MyString"
    email "MyString"
    password_digest "MyString"
    admin false
    activated false
    account_verification_token "MyString"
    account_verification_requested_at "2016-05-15 11:58:16"
    password_reset_token "MyString"
    password_reset_requested_at "2016-05-15 11:58:16"
  end
end
