class Developer < ApplicationRecord
  has_one :user, :as => :account, dependent: :destroy
  has_many :developerproject
end
