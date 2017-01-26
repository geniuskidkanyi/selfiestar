class Like < ApplicationRecord
  belongs_to :selfie, counter_cache: true
end
