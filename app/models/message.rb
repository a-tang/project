class Message < ActiveRecord::Base

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: VALID_EMAIL_REGEX

end
