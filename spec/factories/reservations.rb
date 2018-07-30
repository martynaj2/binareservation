FactoryBot.define do
  factory :reservation do
    title             { Faker::FamilyGuy.character }
    number_of_people  { Faker::Number.between(5, 20) }
    start_date        { Time.now + 1.minutes }
    end_date          { Time.now + 1.hour }
    association :user, factory: :user
    association :hall, factory: :hall
  end
end
