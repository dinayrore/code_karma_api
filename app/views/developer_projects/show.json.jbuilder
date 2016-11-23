json.my_developer_projects(@developer_projects) do |developer_project|
  json.(developer_project, :id, :percentage_complete, :est_completion_date)
  json.project_title developer_project.project.title
  json.brief_description developer_project.project.brief_description
  json.organization_name developer_project.project.client.organization_name
  json.client_email developer_project.project.client.user.email
end
