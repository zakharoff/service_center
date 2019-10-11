FactoryBot.define do
  factory :device do
    name { "Samsung QLED" }
    association :type_device, factory: :type_device
    serial_num { "QE55Q9F" }
  end
end
