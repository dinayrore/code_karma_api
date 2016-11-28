# Belongs to a Developer and has many comments
class KarmaQuestion < ApplicationRecord
  belongs_to :developer
  has_many :karma_comment
end
