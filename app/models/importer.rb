class Importer
  attr_reader :restaurants

  def initialize(json_file_path)
    @restaurants = JSON.parse(File.read(json_file_path))["restaurants"]
  end

  def import
    restaurants.each do |restaurant_hash|
      import_restaurant_plus_dependencies(restaurant_hash)
    end
  end

  private

  def import_restaurant_plus_dependencies(restaurant_hash)
    restaurant = import_restaurant(restaurant_hash["name"])
    import_menus_and_menu_items(restaurant, restaurant_hash["menus"]) if restaurant
  end

  def import_menus_and_menu_items(restaurant, menus)
    menus.each do |menu_hash|
      import_menu_and_menu_items(restaurant, menu_hash)
    end
  end

  def import_menu_and_menu_items(restaurant, menu_hash)
    menu = import_menu(restaurant, menu_hash["name"])
    import_menu_items(menu_hash["menu_items"] || menu_hash["dishes"]) if menu
  end

  def import_menu_items(menu_items)
    menu_items.each do |menu_item_hash|
      import_menu_item(menu_item_hash["name"], menu_item_hash["price"])
    end
  end

  def import_restaurant(name)
    import_model(Restaurant) do
      Restaurant.create!(name: name)
    end
  end

  def import_menu(restaurant, name)
    import_model(Menu) do
      Menu.create!(restaurant: restaurant, name: name)
    end
  end

  def import_menu_item(name, price)
    import_model(MenuItem) do
      MenuItem.create!(name: name, price: price)
    end
  end

  def import_model(model)
    model_instance = yield
    log_success(model, model_instance)
    model_instance
  rescue ActiveRecord::RecordInvalid => e
    log_failure(Restaurant, e.inspect)
  end

  def log_success(model, model_instance)
    puts "Successfully imported #{model.name}: #{model_instance.to_json}"
  end

  def log_failure(model, reason)
    puts "Unable to store #{model.name}, Exception: #{reason}"
  end

end
