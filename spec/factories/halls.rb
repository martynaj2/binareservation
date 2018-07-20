FactoryBot.define do
  factory :hall do
    title     Faker::Book.title
    capacity  Faker::Number.between(5, 20)
  end
end
