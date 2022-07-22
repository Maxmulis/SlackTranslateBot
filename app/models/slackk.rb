class Slackk
  def initialize
    @slack = Slack::Web::Client.new()
  end

  def reply_in_thread(ts, channel, text)
    @slack.chat_postMessage(thread_ts: ts, channel: channel, text: text)
  end

  private

  def message_text(ts, channel)
    response = @slack.conversations_history(channel: channel, latest: ts, inclusive: true, limit: 1)
    response.messages.first.text
  end

end
