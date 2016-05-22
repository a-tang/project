class Competition < ActiveRecord::Base

  belongs_to :user
  belongs_to :category

  validates :title, presence: true
  validates :prize, presence: true

  def user_full_name
    user ? user.full_name : ""
  end

end
