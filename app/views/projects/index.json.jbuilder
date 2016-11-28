json.all_projects(@projects) do |project|
  json.(project, :id, :title, :brief_description, :description, :github_repo_url, :fix_type, :languages)
  json.client_email project.client.user.email
  json.organization_site project.client.organization_site
end
