json.all_developer_rankings(@rank) do |developer|
  json.developer_name developer.user.github_oauth_data
  json.karma_points developer.karma_points
end
