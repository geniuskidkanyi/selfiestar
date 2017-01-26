class Selfy < ApplicationRecord
    is_impressionable
    mount_uploader :photo, PhotoUploader
    belongs_to :user
    has_many :likes
end
