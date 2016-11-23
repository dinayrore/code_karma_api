json.(@question, :id, :karma_question, :created_at)
json.questioner JSON.parse(@question.developer.user.github_oauth_data)['info']['nickname']
json.questioner_image JSON.parse(@question.developer.user.github_oauth_data)['info']['image']
