#
class SessionsController < ApplicationController
  skip_before_action :check_user, only: [:create]

  def create
    data = request.env['omniauth.auth']
    user = User.find_by email: data.info.email
    if user
      update(user, data)
    else
      if params['account'] == 'developer'
        user = create_developer(data)
      else
        user = create_client(data)
      end
    end
    redirect_to "https://samanthasheadavis.github.io/codeKarma/#/redirect/#{user.code_karma_token}"
  end
end
