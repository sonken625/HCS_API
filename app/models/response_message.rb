# frozen_string_literal: true

class ResponseMessage < ApplicationRecord
  belongs_to :request_message
  validates :response_type, presence: true
  validates :params_string, presence: true

  attribute :message_unique_id, :string

  before_validation :set_request_message, if: :request_message_exist?

  scope :after_from_the_id, lambda { |id|
    where('response_messages.id > ?', id) if id.present?
  }


  protected

  def request_message_exist?
    unless message_unique_id.present?
      errors.add :message_unique_id, "can't be blank"
      false
    end

    unless RequestMessage.exists?(message_unique_id: message_unique_id)
      errors.add :message_unique_id, "is invalid (request_message can't be found)"
      false
    end

    true
  end

  def set_request_message
    self.request_message = RequestMessage.find_by_message_unique_id(message_unique_id)
  end
end
