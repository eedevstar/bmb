FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph }
    user
  end
end
