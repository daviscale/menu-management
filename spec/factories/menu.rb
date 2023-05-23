FactoryBot.define do
  factory :menu do
    name { Faker::Lorem.words.join(" ") }
    description { Faker::Lorem.words(number: 100).join(" ") }
    association :restaurant

    transient do
      menu_items_count { 10 }
    end

    menu_items do
      Array.new(menu_items_count) do
        association(:menu_item, menus: [instance])
      end
    end
  end
end
