Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Figaro.env.github_app_id!, Figaro.env.github_app_secret!, scope: 'user,repo'
end
