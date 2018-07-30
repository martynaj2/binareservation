FactoryBot.define do
  factory :group do
    title { Faker::Name.first_name }
    invited_ids ["1,2,3"]
  end
end
