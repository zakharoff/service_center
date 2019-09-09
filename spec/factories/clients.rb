FactoryBot.define do
  factory :client do
    email { 'client@test.com'}
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
