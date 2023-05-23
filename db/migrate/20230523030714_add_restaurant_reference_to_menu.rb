class AddRestaurantReferenceToMenu < ActiveRecord::Migration[7.0]
  def change
    add_reference :menus, :restaurant
  end
end
