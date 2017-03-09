class Comment < ApplicationRecord
  belongs_to :user,dependent: :destroy
  belongs_to :selfy, dependent: :destroy
  validates :body, presence: true
end
