FactoryBot.define do
  factory :reservation do
    title             { Faker::FamilyGuy.character }
    number_of_people  { Faker::Number.between(5, 20) }
    start_date        { Time.now }
    end_date          { Time.now + 1.hour }
    user_id           { Faker::Number.between(0, 20) }
    hall_id           { Faker::Number.between(0, 20) }
  end
end
