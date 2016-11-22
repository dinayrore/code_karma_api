# Belong to Developers and KarmaQuestions both dependent: :destroy
class KarmaComment < ApplicationRecord
  belongs_to :developer, dependent: :destroy
  belongs_to :karma_question, dependent: :destroy
end
