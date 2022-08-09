EMOJIS_TO_LANG = {
  'gb' => 'EN-GB',
  'us' => 'EN-US',
  'flag-mf' => 'FR',
  'flag-bg' => 'BG',
  'de' => 'DE',
  'it' => 'IT'
}.freeze

class Request < ApplicationRecord
  validates :ts, uniqueness: { scope: :target_language }
  validates :target_language, presence: true

  def target_language=(reaction)
    super(EMOJIS_TO_LANG[reaction])
  end
end
