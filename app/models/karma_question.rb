# Belongs to a Developer and has many comments
class KarmaQuestion < ApplicationRecord
  belongs_to :developer, dependent: :destroy
  has_many :karma_comment
end
