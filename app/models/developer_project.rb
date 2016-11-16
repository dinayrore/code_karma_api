# Developer Projects belong to developers and projects, which belong to clients
class DeveloperProject < ApplicationRecord
  belongs_to :developer
  belongs_to :project
end
