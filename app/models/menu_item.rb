# == Schema Information
#
# Table name: menu_items
#
#  id          :bigint           not null, primary key
#  name        :text             not null
#  description :text
#  price       :decimal(10, 2)   not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class MenuItem < ApplicationRecord
  has_and_belongs_to_many :menus

  validates :name, length: { maximum: 300 }
  validates :name, :price, presence: true
  validates :price, comparison: { greater_than_or_equal_to: 0 }
end
