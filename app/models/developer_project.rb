# Developer Projects belong to developers and projects, which belong to clients
class DeveloperProject < ApplicationRecord
  belongs_to :developer, dependent: :destroy
  belongs_to :project, dependent: :destroy
end
