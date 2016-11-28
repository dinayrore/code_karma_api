require 'test_helper'
# polymorphic user relationship, has many projects
class ClientTest < ActiveSupport::TestCase
  def setup
    client = Client.create
    @user = User.new(account_id: client.id, account_type: 'Client', code_karma_token: SecureRandom.uuid, github_token: SecureRandom.uuid, github_oauth_data: "{\"provider\":\"github\"}", email: 'email@example.com')
  end

  test '#project' do
    assert true, @user.account.project
  end
end
