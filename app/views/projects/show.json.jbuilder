json.array! @projects do |project|
  json.(project, :id, :title, :brief_description, :description, :github_repo_url, :fix_type, :languages)
  json.organization_site project.client.organization_site
  json.developer_project project.developer_project do |project|
    json.percent_complete project.percentage_complete
    json.completion_dates project.est_completion_date
    json.developer JSON.parse(project.developer.user.github_oauth_data)['info']['nickname']
  end
end
