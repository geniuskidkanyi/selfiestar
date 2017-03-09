class Selfy < ApplicationRecord
    is_impressionable
    validates :photo, presence: true
    mount_uploader :photo, PhotoUploader, :on => :file_name

    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :winners, dependent: :destroy
    has_many :comments, dependent: :destroy
end
