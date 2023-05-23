# == Schema Information
#
# Table name: menus
#
#  id            :bigint           not null, primary key
#  name          :text             not null
#  description   :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :bigint
#
class Menu < ApplicationRecord
  has_many :menu_items

  validates :name, length: { maximum: 300 }
  validates :name, presence: true
end
