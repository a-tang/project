class UserImage < ActiveRecord::Base
  belongs_to :competition
  mount_uploader :image, ImageUploader
end

# TODO Image uploader not working - not displaying the add extra field / images not saved / images not displayed
