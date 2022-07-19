class Reaction
  include ActiveModel::Model
  attr_reader :emoji, :ts, :channel

  def initialize(attr = {})
    client = Slack::Web::Client.new()
    @emoji = attr['reaction']
    @ts = attr['item']['ts']
    @channel = attr['item']['channel']
  end

  private

  def message_text
    response = client.conversations_history(channel: @channel, latest: @ts, inclusive: true, limit: 1)
    response.messages.first.text
  end


end
