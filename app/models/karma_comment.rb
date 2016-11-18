class KarmaComment < ApplicationRecord
  belongs_to :developer
  belongs_to :karma_question
end
