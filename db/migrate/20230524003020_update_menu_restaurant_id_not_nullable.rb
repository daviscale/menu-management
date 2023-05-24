class UpdateMenuRestaurantIdNotNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :menus, :restaurant_id, false
  end
end
