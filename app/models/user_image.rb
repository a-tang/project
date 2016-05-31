class UserImage < ActiveRecord::Base
  belongs_to :competition
  mount_uploader :image, ImageUploader
end
