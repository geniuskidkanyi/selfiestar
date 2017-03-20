class Subscribe < ApplicationRecord
  validates :email, presence: true,  uniqueness: true
  validates :name, presence: true
end
