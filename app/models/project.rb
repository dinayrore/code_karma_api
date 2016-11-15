class Project < ApplicationRecord
  belongs_to :client
  has_many :developerproject
end
