class Winner < ApplicationRecord

  belongs_to :user, optional: true
  belongs_to :selfy, optional: true

end
