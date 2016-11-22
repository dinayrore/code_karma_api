@client_branch_response.each do |branch|
  json.base_branches @base_branches << {name: branch["name"]}
end

@developer_branch_response.each do |branch|
  json.head_branches @head_branches << {name: branch["name"]}
end
