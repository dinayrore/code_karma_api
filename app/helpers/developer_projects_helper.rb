#
module DeveloperProjectsHelper
  def valid?
    @developer_project.developer == @current_user.account
  end
end
