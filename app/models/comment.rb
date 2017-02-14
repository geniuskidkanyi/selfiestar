class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :selfy
  validates :body, presence: true
end
