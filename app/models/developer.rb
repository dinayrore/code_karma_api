# Developers are users through account (polymorphic), they have many devprojects
class Developer < ApplicationRecord
  has_one :user, :as => :account, dependent: :destroy
  has_many :developerproject
end
