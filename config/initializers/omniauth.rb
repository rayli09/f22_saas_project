Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"],ENV["GOOGLE_CLIENT_SECRET"], {access_type: 'online'}
end
OmniAuth.config.logger = Rails.logger if Rails.env.development?