FactoryBot.define do
  factory :organization do
    name { "Test Inc." }
    association :form, factory: :form
    inn { 123456 }
    ogrn { 1234567890123 }
  end
end
