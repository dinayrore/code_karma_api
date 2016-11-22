# Clients own projects and projects may be included in several devprojects
class Project < ApplicationRecord
  belongs_to :client, dependent: :destroy
  has_many :developer_project
end
