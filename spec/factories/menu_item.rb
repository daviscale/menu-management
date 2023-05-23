FactoryBot.define do
  factory :menu_item do
    name { Faker::Food.dish }
    description { Faker::Food.description }
    price { Faker::Number.decimal(l_digits: 2) }

    transient do
      menus_count { 3 }
    end

    menus do
      Array.new(menus_count) do
        association(:menu, menu_items: [instance])
      end
    end
  end
end
