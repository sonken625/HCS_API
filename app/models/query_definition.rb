# frozen_string_literal: true

class QueryDefinition < ApplicationRecord
  belongs_to :hct
  enum protocol_type: {json: 0, file: 1}
  validates :protocol_type, presence: true

  validates :search_key, uniqueness: true, presence: true
  before_validation :generate_search_key

  def generate_search_key
    loop do
      search_key = SecureRandom.urlsafe_base64(24).tr('lIO0', 'nbjh')
      unless QueryDefinition.exists?(search_key: search_key)
        self.search_key = search_key
        break
      end
    end
  end

  def update_search_key
    loop do
      old_search_key = search_key
      search_key = SecureRandom.urlsafe_base64(24).tr('lIO0', 'sxyz')
      next if old_search_key == search_key

      break token if begin
        update!(search_key: search_key)
      rescue StandardError
        false
      end
    end
  end
end
