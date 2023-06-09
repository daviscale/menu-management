# == Schema Information
#
# Table name: restaurants
#
#  id         :bigint           not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Restaurant < ApplicationRecord
  has_many :menus

  validates :name, length: { maximum: 300 }
  validates :name, presence: true
end
