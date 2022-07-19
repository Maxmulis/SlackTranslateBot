class Api::V1::TranslationsController < ApplicationController

  def translate
    if params['type'] == 'url_verification'
      render json: { 'challenge': params['challenge'] }, status: :ok
      # Check if reaction is a flag-emoji, if it is: save :message, :ts, :channel
    elsif params['event']['type'] == 'reaction_added'
      render status: :ok
      reaction = Reaction.new(params['event'])
      client = Slack::Web::Client.new()
      # Reply to message by using :thread_ts, :channel and :text
      client.chat_postMessage(thread_ts: reaction.ts, channel: reaction.channel, text: ":#{reaction.emoji}:")

    end

    # Read message and extract text
  end

  private

  def reaction_params
    params.permit(:emoji, :ts, :channel)
  end
end
