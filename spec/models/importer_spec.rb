require 'rails_helper'

RSpec.describe Importer do
  let(:importer) { Importer.new("./resources/restaurant_data.json") }
  let(:restaurant_name) { Faker::Restaurant.name }
  let(:menu_name) { Faker::Lorem.word }
  let(:menu_item_name) { Faker::Food.dish }
  let(:menu_item_price) { Random.rand(200.0) }

  let(:restaurant) { FactoryBot.create(:restaurant) }

  let(:menu_items) do
    [
      {"name" => Faker::Food.dish, "price" => 23.50},
      {"name" => Faker::Food.dish, "price" => 12.75}
    ]
  end
  let(:menu_hash) do
    {
      "name" => "Lunch",
      "menu_items" => menu_items
    }
  end
  let(:menus) do
    [
      { "name" => "Breakfast", "menu_items" => menu_items },
      { "name" => "Lunch", "menu_items" => menu_items }
    ]
  end

  describe "#import_restaurant" do
    context "when validation is successful" do
      it "returns a new Restaurant" do
        restaurant = importer.send(:import_restaurant, restaurant_name)
        expect(restaurant).to be_a Restaurant
        expect(restaurant.name).to eq(restaurant_name)
      end

      it "creates a new Restaurant" do
        restaurant = importer.send(:import_restaurant, restaurant_name)
        expect(Restaurant.find(restaurant.id)).to eq(restaurant)
      end

      it "logs a success message" do
        expect(importer).to receive(:log_success)
        restaurant = importer.send(:import_restaurant, restaurant_name)
      end
    end

    context "when validation is unsuccessful" do
      it "returns nil" do
        restaurant = importer.send(:import_restaurant, nil)
        expect(restaurant).to be_nil
      end

      it "does not create a restaurant" do
        expect(Restaurant).to receive(:create!).and_raise(ActiveRecord::RecordInvalid)
        restaurant = importer.send(:import_restaurant, nil)
      end

      it "logs a failure message" do
        expect(importer).to receive(:log_failure)
        restaurant = importer.send(:import_restaurant, nil)
      end
    end
  end

  describe "#import_menu" do
    context "when validation is successful" do
      it "returns a new Menu" do
        menu = importer.send(:import_menu, restaurant, menu_name)
        expect(menu).to be_a Menu
        expect(menu.name).to eq(menu_name)
        expect(menu.restaurant).to eq(restaurant)
      end

      it "creates a new Menu" do
        menu = importer.send(:import_menu, restaurant, menu_name)
        expect(Menu.find(menu.id)).to eq(menu)
      end

      it "logs a success message" do
        expect(importer).to receive(:log_success)
        menu = importer.send(:import_menu, restaurant, menu_name)
      end
    end

    context "when validation is unsuccessful" do
      it "returns nil" do
        menu = importer.send(:import_menu, nil, nil)
        expect(menu).to be_nil
      end

      it "does not create a restaurant" do
        expect(Menu).to receive(:create!).and_raise(ActiveRecord::RecordInvalid)
        menu = importer.send(:import_menu, nil, nil)
      end

      it "logs a failure message" do
        expect(importer).to receive(:log_failure)
        menu = importer.send(:import_menu, nil, nil)
      end
    end
  end

  describe "#import_menu_item" do
    context "when validation is successful" do
      it "returns a new MenuItem" do
        menu_item = importer.send(:import_menu_item, menu_item_name, menu_item_price)
        expect(menu_item).to be_a MenuItem
        expect(menu_item.name).to eq(menu_item_name)
        expect(menu_item.price).to be_within(0.01).of(menu_item_price)
      end

      it "creates a new MenuItem" do
        menu_item = importer.send(:import_menu_item, menu_item_name, menu_item_price)
        expect(MenuItem.find(menu_item.id)).to eq(menu_item)
      end

      it "logs a success message" do
        expect(importer).to receive(:log_success)
        menu_item = importer.send(:import_menu_item, menu_item_name, menu_item_price)
      end
    end

    context "when validation is unsuccessful" do
      it "returns nil" do
        menu_item = importer.send(:import_menu_item, nil, nil)
        expect(menu_item).to be_nil
      end

      it "does not create a MenuItem" do
        expect(MenuItem).to receive(:create!).and_raise(ActiveRecord::RecordInvalid)
        menu_item = importer.send(:import_menu_item, nil, nil)
      end

      it "logs a failure message" do
        expect(importer).to receive(:log_failure)
        menu_item = importer.send(:import_menu_item, nil, nil)
      end
    end
  end

  describe "#import_menu_items" do
    it "calls #import_menu_item for each item in the array" do
      (0..1).each do |i|
        expect(importer).to receive(:import_menu_item).with(menu_items[i]["name"], menu_items[i]["price"])
      end
      importer.send(:import_menu_items, menu_items)
    end
  end

  describe "#import_menu_and_menu_items" do
    it "calls #import_menu" do
      expect(importer).to receive(:import_menu).with(restaurant, menu_hash["name"])
      importer.send(:import_menu_and_menu_items, restaurant, menu_hash)
    end

    it "calls #import_menu_items" do
      expect(importer).to receive(:import_menu_items).with(menu_hash["menu_items"])
      importer.send(:import_menu_and_menu_items, restaurant, menu_hash)
    end
  end

  describe "#import_menus_and_menu_items" do
    it "calls #import_menu_and_menu_items for each menu in the hash" do
      (0..1).each do |i|
        expect(importer).to receive(:import_menu_and_menu_items).with(restaurant, menus[i])
      end
      importer.send(:import_menus_and_menu_items, restaurant, menus)
    end
  end

  describe "#import" do
    it "should load all the restaurants in the JSON file" do
      importer.import
      expect(Restaurant.count).to eq(2)
    end

    it "should load all the menus in the JSON file" do
      importer.import
      expect(Menu.count).to eq(4)
    end

    it "should load all the menu items in the JSON file" do
      importer.import
      expect(MenuItem.count).to eq(9)
    end
  end
end
