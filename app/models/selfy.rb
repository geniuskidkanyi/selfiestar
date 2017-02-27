class Selfy < ApplicationRecord
    is_impressionable
    validates :photo, presence: true
    mount_uploader :photo, PhotoUploader, :on => :file_name

    belongs_to :user
    has_many :likes
    has_many :winners
    has_many :comments
end
