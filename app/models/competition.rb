class Competition < ActiveRecord::Base

  belongs_to :user
  belongs_to :category

  validates :title, presence: true
  validates :prize, presence: true

  has_many :user_images, dependent: :destroy
  accepts_nested_attributes_for :user_images, reject_if: :all_blank, allow_destroy: true


  def user_full_name
    user ? user.full_name : ""
  end

end
