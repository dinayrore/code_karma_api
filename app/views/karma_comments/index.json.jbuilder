json.all_questions_and_comments(@comments) do |comment|
  json.(comment, :id, :karma_comment, :comment_like, :created_at)
  json.question_id comment.karma_question_id
  json.question comment.karma_question.karma_question
  json.question_likes comment.karma_question.question_like
  json.question_time comment.karma_question.created_at
  json.questioner comment.karma_question.developer.user.github_oauth_data
end
