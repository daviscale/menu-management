# == Schema Information
#
# Table name: menus
#
#  id            :bigint           not null, primary key
#  name          :text             not null
#  description   :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :bigint           not null
#
class Menu < ApplicationRecord
  belongs_to :restaurant
  has_and_belongs_to_many :menu_items

  validates :name, length: { maximum: 300 }
  validates :name, :restaurant, presence: true
end
