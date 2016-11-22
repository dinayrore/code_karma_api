json.(@comment, :id, :karma_comment, :created_at)
json.commenter JSON.parse(@comment.developer.user.github_oauth_data)['info']['nickname']
json.image JSON.parse(@comment.developer.user.github_oauth_data)['info']['image']
