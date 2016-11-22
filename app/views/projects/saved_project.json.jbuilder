json.(@project, :id, :title, :brief_description, :description, :github_repo_url, :fulfilled, :fix_type)

@language_response.each do |language|
  @sum += language.second
end

@language_response.each do |language|
  json.language_percent @language_percent << { language.first => (language.second * 100) / @sum}
end
