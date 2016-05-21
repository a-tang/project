class Competition < ActiveRecord::Base

  belongs_to :user
  belongs_to :category

  validates :title, presence: true
  validates :prize, presence: true

end
