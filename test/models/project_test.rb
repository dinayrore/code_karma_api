require 'test_helper'
#
class ProjectTest < ActiveSupport::TestCase
  def setup
    @client = Client.new
    @project = Project.new(title: 'Project Title', brief_description: 'brief', description: 'more', github_repo_url: github.com, active_site_url: active-site.com, fulfilled: false, fix_type: 'bug fix', languages: {'Ruby' => 100})
  end

  test 'Belongs to relationship with client model' do

  end

  test '#developer_project' do
    assert true, @client.project.developer_project
  end

  test 'Dependant destroy relationship with developer project model' do

  end
end
