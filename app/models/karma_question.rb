class KarmaQuestion < ApplicationRecord
  belongs_to :developer
  has_many :karmacomment
end
