FactoryBot.define do
  factory :firm,class: Firm do
    transient do
      firm_base_name "firm"
    end


    sequence(:name){ |n| "#{n}:#{firm_base_name}"}
    active true
  end
end
