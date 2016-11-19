#
module SessionsHelper
  def update(user, data)
    user.update!(
      github_token:      data.credentials.token,
      github_oauth_data: data.to_json
    )
  end

  def create_developer(data)
    developer = Developer.create!
    user = User.create!(
      account:           developer,
      code_karma_token:  SecureRandom.uuid,
      github_token:      data.credentials.token,
      github_oauth_data: data.to_json,
      email:             data.info.email,
      nickname:          data.info.nickname
    )
    user
  end

  def create_client(data)
    client = Client.create!
    user = User.create!(
      account:           client,
      code_karma_token:  SecureRandom.uuid,
      github_token:      data.credentials.token,
      github_oauth_data: data.to_json,
      email:             data.info.email,
      nickname:          data.info.nickname
    )
    user
  end

end
