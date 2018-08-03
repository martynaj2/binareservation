FactoryBot.define do
  factory :reservation do
    title             { Faker::FamilyGuy.character }
    number_of_people  { Faker::Number.between(5, 20) }
    start_date        { DateTime.new(2032, 8, 29, 07, 35, 0) }
    end_date          { DateTime.new(2032, 8, 29, 16, 35, 0) }
    association :user, factory: :user
    association :hall, factory: :hall
  end
end
