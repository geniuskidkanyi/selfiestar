class Like < ApplicationRecord
  belongs_to :selfy, counter_cache: true
end
