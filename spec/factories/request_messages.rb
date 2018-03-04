FactoryBot.define do
  factory :request_message do
    search_key "testtesttest"
    association :query_definition
    association :sender_hct, factory: :hct

    after(:build) do |request|
      request.query_definition.search_key = search_key
    end
  end
end
