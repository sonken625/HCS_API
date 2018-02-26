json.extract! response_message, :id, :created_at, :updated_at
json.url response_message_url(response_message, format: :json)
