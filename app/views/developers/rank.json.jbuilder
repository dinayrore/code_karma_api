r = 1
json.all_developer_rankings(@top_rank) do |developer|
  json.developer_name JSON.parse(developer.user.github_oauth_data)["info"]["nickname"]
  json.developer_image JSON.parse(developer.user.github_oauth_data)["info"]["image"]
  json.karma_points developer.karma_points
  json.developer_rank r
  r += 1
  json.total_developers @count
end
