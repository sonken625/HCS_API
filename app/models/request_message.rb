# frozen_string_literal: true

class RequestMessage < ApplicationRecord
  belongs_to :query_definition
  has_many :response_message
  belongs_to :sender_hct, class_name: 'Hct'


  attribute :search_key, :string

  validates :query_definition, presence: true
  validates :search_key,presence: true
  validates :message_unique_id, presence: true, uniqueness: true

  before_validation :generate_message_unique_id
  before_validation :set_query_definition


  scope :after_from_the_message_id, lambda { |message_id|
    where('id > ?', message_id) if message_id.present?
  }

  scope :search_with_query_definition, lambda { |query_definition|
    where(query_definition_id: query_definition.id)
  }


  def to_param
    message_unique_id
  end

  private

  def generate_message_unique_id
    loop do
      message_unique_id = SecureRandom.urlsafe_base64(5).tr('lIO0', 'nbjh')

      unless RequestMessage.exists?(message_unique_id: message_unique_id)
        self.message_unique_id = message_unique_id
        break
      end
    end
  end

  def set_query_definition
    query_definition = QueryDefinition.find_by_search_key(search_key)
    if query_definition
      self.query_definition = query_definition
    else
      errors.add :search_key,"が不正です"
      throw :abort
    end
  end

end
