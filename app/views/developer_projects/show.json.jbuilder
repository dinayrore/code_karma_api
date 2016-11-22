json.my_developer_projects(@developer_projects) do |developer_project|
  json.(developer_project, :id, :percentage_complete, :est_completion_date)
  json.client_email developer_project.project.client.user.email
end
