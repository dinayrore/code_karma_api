json.all_projects(@projects) do |project|
  json.(project, :id, :title, :brief_description, :description, :github_repo_url)
  json.client_email project.client.user.email
end
