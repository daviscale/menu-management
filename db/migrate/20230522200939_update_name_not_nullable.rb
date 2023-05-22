class UpdateNameNotNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :menus, :name, false
    change_column_null :menu_items, :name, false
  end
end
