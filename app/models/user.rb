class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

has_many :likes
has_many :selfies
def likes?(selfy)
  selfy.likes.where(user_id: id).any?
end

end
