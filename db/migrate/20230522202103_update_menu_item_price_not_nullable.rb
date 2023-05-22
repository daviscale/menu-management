class UpdateMenuItemPriceNotNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :menu_items, :price, false
  end
end
