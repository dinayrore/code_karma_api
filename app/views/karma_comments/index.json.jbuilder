json.array! @questions do |question|
  json.question question.karma_question
  json.likes question.question_like
  json.created question.created_at
  json.questioner JSON.parse(question.developer.user.github_oauth_data)['info']['nickname']
  json.questioner_image JSON.parse(question.developer.user.github_oauth_data)['info']['image']
  json.comments question.karma_comment do |comment|
    json.id comment.id
    json.comment comment.karma_comment
    json.likes comment.comment_like
    json.created comment.created_at
    json.commenter JSON.parse(comment.developer.user.github_oauth_data)['info']['nickname']
    json.image JSON.parse(comment.developer.user.github_oauth_data)['info']['image']
  end
end
