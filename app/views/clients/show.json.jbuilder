json.user do
  json.data @user.github_oauth_data
end

json.call(@client, :organization_name, :organization_site)
