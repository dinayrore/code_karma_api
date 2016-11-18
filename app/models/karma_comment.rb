class KarmaComment < ApplicationRecord
  belongs_to :developer
  belongs_to :karmaquestion
end
