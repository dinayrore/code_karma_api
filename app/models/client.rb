# Clients are users through account (polymorphic), they have many projects
class Client < ApplicationRecord
  has_one :user, as: :account
  has_many :project
end
