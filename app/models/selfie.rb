class Selfie < ApplicationRecord
    is_impressionable
    mount_uploader :photo, PhotoUploader
    belongs_to :user
    has_many :likes
    scope :winner, -> (limit) { order("created_at desc").limit(limit) }
end
