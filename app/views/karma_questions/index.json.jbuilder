json.all_questions(@questions) do |question|
  json.(question, :id, :karma_question, :question_like, :created_at, :updated_at)
  # json.questioner karma_question.developer.user.nickname
end
