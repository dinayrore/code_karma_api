#
class SessionsController < ApplicationController
  skip_before_action :check_user, only: [:create]

  def create
    data = request.env['omniauth.auth']
    user = User.find_by email: data.info.email
    if user
      user.update!(
        github_token:      data.credentials.token,
        github_oauth_data: data.to_json
      )
    else
      if params['account'] == 'developer'
        developer = Developer.create!
        user = User.create!(
          account:           developer,
          code_karma_token:  SecureRandom.uuid,
          github_token:      data.credentials.token,
          github_oauth_data: data.to_json,
          email:             data.info.email
        )
      else
        client = Client.create!
        user = User.create!(
          account:           client,
          code_karma_token:  SecureRandom.uuid,
          github_token:      data.credentials.token,
          github_oauth_data: data.to_json,
          email:             data.info.email
        )
      end
    end

    redirect_to "https://samanthasheadavis.github.io/codeKarma/#/redirect/#{user.code_karma_token}"
  end
end
