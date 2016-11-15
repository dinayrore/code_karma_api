class Developer < ApplicationRecord
  has_one :user, :as => :account, dependant: :destroy
end
