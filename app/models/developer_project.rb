class DeveloperProject < ApplicationRecord
  belongs_to :developer
  belongs_to :project 
end
