# frozen_string_literal: true

FactoryBot.define do
  factory :query_definition do
    association :hct
    protocol_type 0

    trait :with_admin do
      association :hct, factory: %i[hct with_admin]
    end
  end
end
