class Client < ApplicationRecord
  has_one :user, :as => :account, dependent: :destroy
  has_many :project
end
