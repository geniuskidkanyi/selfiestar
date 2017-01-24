class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

has_many :likes

def likes?(selfie)
  selfie.likes.where(user_id: id).any?
end

end
