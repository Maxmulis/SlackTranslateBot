Slack.configure do |config|
  config.token = Rails.application.credentials.slack.bot_token
end
