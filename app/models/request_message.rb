# frozen_string_literal: true

class RequestMessage < ApplicationRecord
  belongs_to :query_definition
  has_one :response_message, primary_key: 'message_unique_id', foreign_key: :request_message_id
  belongs_to :sender_hct, class_name: 'Hct'

  attribute :search_key, :string

  scope :after_from_the_message_id, lambda { |message_id|
    where('id > ?', message_id) if message_id.present?
  }

  scope :query_definition, lambda { |query_definition|
    where(query_definition_id: query_definition.id)
  }

  def to_param
    message_unique_id
  end

  validates :query_definition, presence: true
  validates :search_key,presence: true
  validates :message_unique_id, presence: true, uniqueness: true

  before_validation :generate_message_unique_id
  before_validation :set_query_definition

  private

  def generate_message_unique_id
    loop do
      message_unique_id = SecureRandom.urlsafe_base64(24).tr('lIO0', 'nbjh')

      unless RequestMessage.exists?(message_unique_id: message_unique_id)
        self.message_unique_id = message_unique_id
        break
      end
    end
  end

  def set_query_definition
    self.query_definition = QueryDefinition.find_by_search_key(search_key)
  end

end
