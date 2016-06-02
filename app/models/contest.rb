class Contest < ActiveRecord::Base
  has_many :entries, dependent: :destroy
  has_many :entered_users, through: :entries, source: :user
  has_many :user_images, dependent: :destroy

  accepts_nested_attributes_for :user_images,
  reject_if:     :all_blank,
  allow_destroy: true

  belongs_to :user
  belongs_to :category

  validates :title, presence: true
  validates :prize, presence: true

  accepts_nested_attributes_for :user_images, reject_if: :all_blank, allow_destroy: true

  mount_uploader :image, ImageUploader
  mount_uploaders :images, ImageUploader

  def entry_value
    entries.up_count - entries.down_count
  end

  def user_full_name
    user ? user.full_name : ""
  end

  def entry_for(user)
    entries.find_by_user_id user if user
  end

  def deadline
    
  end

end
