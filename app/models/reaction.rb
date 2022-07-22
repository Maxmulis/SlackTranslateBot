EMOJIS_TO_LANG = {
  'gb' => 'EN-GB',
  'us' => 'EN-US',
  'flag-mf' => 'FR',
  'flag-bg' => 'BG',
  'de' => 'DE',
  'it' => 'IT'
}.freeze

class Reaction
  include ActiveModel::Model
  attr_reader :ts, :channel, :target_language

  validates :target_language, presence: true

  def initialize(attr)
    @slack = Slack::Web::Client.new
    @target_language = EMOJIS_TO_LANG[attr['reaction']]
    @ts = attr['item']['ts']
    @channel = attr['item']['channel']
  end

  def text
    response = @slack.conversations_history(channel: @channel, latest: @ts, inclusive: true, limit: 1)
    response.messages.first.text
  end
end
