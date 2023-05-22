# == Schema Information
#
# Table name: menu_items
#
#  id          :bigint           not null, primary key
#  name        :text             not null
#  description :text
#  price       :decimal(10, 2)   not null
#  menu_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
