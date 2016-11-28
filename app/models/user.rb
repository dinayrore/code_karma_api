# Users can be Clients or Developers (polymorphic)
class User < ApplicationRecord
  belongs_to :account, polymorphic: true
  validates :code_karma_token, :github_token, :github_oauth_data, :email, presence: true
end
