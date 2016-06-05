class User < ActiveRecord::Base
  has_many :contests, dependent: :nullify
  has_many :entries, dependent: :destroy
  has_many :entered_contests, through: :entries, source: :contest
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true, unless: :with_oauth?

  with_options if: :customer? do |customer|
    customer.validates :company_name, presence: true
    customer.validates :company_address, presence: true
    customer.validates :company_phone_number, presence: true
    customer.validates :company_address, presence: true
  end

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email, uniqueness: true, presence: true, format: VALID_EMAIL_REGEX, unless: :with_oauth?

  serialize :twitter_raw_data, Hash

  def with_oauth?
    provider.present? && uid.present?
  end

  def from_omniauth?
    uid.present? && provider.present?
  end

  def self.find_or_create_with_twitter(omniauth_data)
  user = User.where(provider: "twitter", uid: omniauth_data["uid"]).first
  unless user
    full_name = omniauth_data["info"]["name"]
    user = User.create!(first_name:      extract_first_name(full_name),
                       last_name:        extract_last_name(full_name),
                       provider:         "twitter",
                       uid:              omniauth_data["uid"],
                       password:         SecureRandom.hex(16),
                       twitter_token:    omniauth_data["credentials"]["token"],
                       twitter_secret:   omniauth_data["credentials"]["secret"],
                       twitter_raw_data: omniauth_data)
    end
    user
  end

  def customer?
    user_type == "customer"
  end

  def full_name
   "#{first_name} #{last_name}"
  end

  def user_full_name
   user ? user.full_name : ""
  end

  def user_company_name
    company_name ? company_name : ""
  end

  def generate_password_reset_data
    generate_password_reset_token
    self.password_reset_requested_at = Time.now
    save
  end

  def password_reset_expired?
    password_reset_requested_at <=60.minutes.ago
  end

  def generate_account_verification_data
    generate_account_verification_token
    self.account_verification_requested_at = Time.now
    save
  end

  def generate_account_verification_token
    begin
      self.account_verification_token = SecureRandom.hex(32)
    end while User.exists?(account_verification_token: self.account_verification_token)
  end

  def generate_password_reset_token
    begin
      self.password_reset_token = SecureRandom.hex(32)
    end while User.exists?(password_reset_token: self.password_reset_token)
  end

  def titleize_title
    self.title - title.titleize
  end

  def attempt_password_change(old_password, new_password)
    self.errors.add(:password, "Invalid Password") if !authenticate old_password
    self.errors.add(:password, "New password should be different than old password") if old_password == new_password
    self.errors.add(:password, "Password cannot be empty") if new_password.blank?
    errors.any? ? false : update(password: new_password)
  end

  private

  def self.extract_first_name(full_name)
    if full_name.rindex(" ")
      full_name[0..full_name.rindex(" ")-1]
    else
      full_name
    end
  end

  def self.extract_last_name(full_name)
    if full_name.rindex(" ")
      full_name.split.last
    else
      ""
    end
  end

end
