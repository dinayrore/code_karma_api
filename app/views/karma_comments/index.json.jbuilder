json.all_comments(@comments) do |comment|
  json.(comment, :id, :karma_comment, :comment_like, :created_at, :updated_at)
  # json.commenter karma_comment.developer.user.nickname
end
