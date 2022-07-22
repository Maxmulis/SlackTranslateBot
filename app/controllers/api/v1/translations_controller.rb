class Api::V1::TranslationsController < ApplicationController
  def translate
    slack_request = Slack::Events::Request.new(request)
    if params['type'] == 'url_verification' && slack_request.verify!
      render json: { challenge: params['challenge'] }, status: :ok
      # Check if reaction is a flag-emoji, if it is: save :message, :ts, :channel
    elsif params['event']['type'] == 'reaction_added' && slack_request.verify!
      render status: :ok
      reaction = Reaction.new(params['event'])
      if reaction.valid?
        # Read message and extract text for translation
        translated_text = Message.new(source_text: reaction.text, target_language: reaction.target_language).translate

        # Reply to message by using :thread_ts, :channel and :text
        Slackk.new.reply_in_thread(reaction.ts, reaction.channel, translated_text)
        # Translate text

      end
    end
  end

  private

  def reaction_params
    params.permit(:emoji, :ts, :channel)
  end
end
