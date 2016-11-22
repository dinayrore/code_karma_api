# OAuth through GitHub to create & update user/clients
class ClientsController < ApplicationController
  include ClientsHelper

  def show
    find_user
    if confirm_account_type
      identify_client
      show_client_user_data
    else
      user_error
    end
  end

  def update
    find_user
    if confirm_account_type
      identify_client
      edit_client_params
      show_client_user_data
    else
      user_error
    end
  end
end
