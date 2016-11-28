require 'test_helper'
# polymorphic relationship
class UserTest < ActiveSupport::TestCase
  def setup
    developer = Developer.create
    @user = User.new(account_id: developer.id, account_type: 'Developer', code_karma_token: SecureRandom.uuid, github_token: SecureRandom.uuid, github_oauth_data: "{\"provider\":\"github\"}", email: 'email@example.com')
  end

  test 'valid user' do
    assert @user.valid?
  end

  test 'invalid without account_id' do
    @user.account_id = nil
    refute @user.valid?, 'user cannot exist without polymorphic association'
  end

  test 'invalid without account_type' do
    @user.account_type = nil
    refute @user.valid?, 'user cannot exist without polymorphic association'
  end

  test 'invalid without code_karma_token' do
    @user.code_karma_token = nil
    refute @user.valid?, 'user cannot exist without code karma token'
  end

  test 'invalid without github_token' do
    @user.github_token = nil
    refute @user.valid?, 'user cannot exist without github token'
  end

  test 'invalid without github_oauth_data' do
    @user.github_oauth_data = nil
    refute @user.valid?, 'user cannot exist without github oauth data'
  end

  test 'invalid without email' do
    @user.email = nil
    refute @user.valid?, 'user cannot exist without email'
  end
end
