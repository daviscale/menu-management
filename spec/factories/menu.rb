FactoryBot.define do
  factory :menu do
    name { Faker::Lorem.words.join(" ") }
    description { Faker::Lorem.words(number: 100).join(" ") }
  end
end
