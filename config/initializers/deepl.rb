DeepL.configure do |config|
  config.auth_key = Rails.application.credentials.deepl.auth_key
  config.host = 'https://api-free.deepl.com' # Default value is 'https://api.deepl.com'
end
