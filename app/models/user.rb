# Users can be Clients or Developers (polymorphic)
class User < ApplicationRecord
  belongs_to :account, polymorphic: true
end
