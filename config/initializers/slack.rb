Slack.configure do |config|
  config.token = Rails.application.credentials.slack.bot_token
end

Slack::Events.configure do |config|
  config.signing_secret = Rails.application.credentials.slack.signing_secret
end
