class UserImage < ActiveRecord::Base
  belongs_to :contest
  mount_uploader :image, ImageUploader

end
