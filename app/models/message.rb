class Message
  def initialize(args)
    @source_text = args[:source_text]
    @target_language = args[:target_language]
  end

  def translate
    DeepL.translate(@source_text, nil, @target_language)
  end

  private

  def compose_message; end
end
