# Belong to Developers and KarmaQuestions both dependent: :destroy
class KarmaComment < ApplicationRecord
  belongs_to :developer
  belongs_to :karma_question, dependent: :destroy
end
