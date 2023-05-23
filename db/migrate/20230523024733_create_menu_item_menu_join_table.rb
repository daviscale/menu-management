class CreateMenuItemMenuJoinTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :menu_items, :menu_id
    create_join_table :menus, :menu_items
  end
end
