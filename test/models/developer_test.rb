require 'test_helper'
# polymorphic user relationship, has many questions, comments, and projects
class DeveloperTest < ActiveSupport::TestCase
  def setup
    developer = Developer.create
    @user = User.new(account_id: developer.id, account_type: 'Developer', code_karma_token: SecureRandom.uuid, github_token: SecureRandom.uuid, github_oauth_data: "{\"provider\":\"github\"}", email: 'email@example.com')
  end

  test '#karma_question' do
    assert true, @user.account.karma_question
  end

  test '#karma_comment' do
    assert true, @user.account.karma_comment
  end

  test '#developer_project' do
    assert true, @user.account.developer_project
  end
end
