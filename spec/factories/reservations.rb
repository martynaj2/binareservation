FactoryBot.define do
  factory :reservation do
    title             Faker::FamilyGuy.character
    description       Faker::FamilyGuy.quote
    number_of_people  Faker::Number.between(5, 20)
    start_date        Time.now
    end_date          Time.now + 1.hour
    user_id           1
    hall_id           6
  end
end
