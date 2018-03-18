
OmniAuth.config.logger = Rails.logger

Rails.application.middleware.use OmniAuth::Builder do
   provider_name = "google_oauth2"
   provider "#{provider_name}", ENV["#{provider_name.upcase}_API_KEY"],
   ENV["#{provider_name.upcase}_API_SECRET"], {
      prompt: 'select_account',
      scope: 'email https://www.google.com/m8/feeds/',
      ssl: {ca_file: Rails.root.join("cacert.pem").to_s}
  }
end
