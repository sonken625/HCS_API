FactoryBot.define do
  factory :hct, class: Hct do
    role :normal

    transient do
      firm_name "normal_firm"
    end

    trait :with_admin do
      transient do
        firm_name "admin"
      end

      role :admin
    end

    # association :firm, factory: :firm, firm_base_name: "#{firm_name}"
    after(:build) do |hct, evaluator|
      hct.firm = FactoryBot.create(:firm, firm_base_name: evaluator.firm_name)
    end




  end
end
