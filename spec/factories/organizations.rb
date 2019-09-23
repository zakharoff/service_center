FactoryBot.define do
  factory :organization do
    name { "Test Inc." }
    association :form, factory: :form
    inn { 123456 }
    ogrn { 123456789123 }
  end
end
