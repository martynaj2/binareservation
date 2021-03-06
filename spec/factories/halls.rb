FactoryBot.define do
  factory :hall do
    title       { Faker::Name.first_name }
    capacity    { Faker::Number.between(5, 20) }
    hall_color  { Faker::Color.hex_color }
  end
end
