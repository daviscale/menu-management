# == Schema Information
#
# Table name: menu_items
#
#  id          :bigint           not null, primary key
#  name        :text             not null
#  description :text
#  price       :decimal(10, 2)
#  menu_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class MenuItem < ApplicationRecord
  belongs_to :menu
end
