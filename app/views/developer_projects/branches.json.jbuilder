@branch_response.each do |branch|
  json.branches_array @branches << {name: branch["name"]}
end
