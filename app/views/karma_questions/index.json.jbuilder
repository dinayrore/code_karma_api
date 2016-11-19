# json.all_questions(@questions) do |question|
#   json.(question, :id, :karma_question, :question_like, :created_at, :updated_at)
#   # json.questioner karma_question.developer.user.nickname
# end

json.all_comments(@comments) do |comment|
  json.(comment, :id, :karma_comment, :comment_like, :created_at, :updated_at)
  # json.question karma_comment.karma_question_id.karma_question
  # json.commenter karma_comment.developer.user.nickname
end
