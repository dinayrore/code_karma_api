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
      user = User.create!(

        account_type:      data.account,
        code_karma_token:  SecureRandom.uuid,
        github_token:      data.credentials.token,
        github_oauth_data: data.to_json,
        email:             data.info.email
      )
    end

    redirect_to "https://samanthasheadavis.github.io/codeKarma/#/redirect/#{user.code_karma_token}"
  end
end
