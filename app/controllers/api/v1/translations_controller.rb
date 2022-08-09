class Api::V1::TranslationsController < ApplicationController
  def translate
    # Create instance of Request with: ts, channel, reaction, user, type
    slack_request = Slack::Events::Request.new(request)
    if params['type'] == 'url_verification' && slack_request.verify!
      render json: { challenge: params['challenge'] }, status: :ok
      # Check if reaction is a flag-emoji, if it is: save :message, :ts, :channel
    elsif params['event']['type'] == 'reaction_added' && slack_request.verify!
      render status: :ok
      request = Request.new(ts: params['event']['item']['ts'],
                            channel: params['event']['item']['channel'],
                            target_language: params['event']['reaction'],
                            item_user: params['event']['item']['item_user'],
                            reaction_type: params['event']['item']['type'])
      if request.save
        #   - retrieve text from slack
        slack = Slack::Web::Client.new
        slack_response = slack.conversations_history(channel: request.channel, latest: request.ts, inclusive: true,
                                                     limit: 1)
        text = slack_response.messages.first.text
        translated_text = DeepL.translate(text, nil, request.target_language)
        slack.chat_postMessage(thread_ts: request.ts, channel: request.channel, text: translated_text)
      end
    end
  end

  private

  def request_params
    params.permit(:ts, :channel, :target_language, :user, :type)
  end
end
