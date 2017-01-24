class Selfie < ApplicationRecord
   mount_uploader :photo, PhotoUploader
  belongs_to :user
  has_many :likes
end
