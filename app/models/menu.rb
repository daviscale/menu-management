# == Schema Information
#
# Table name: menus
#
#  id          :bigint           not null, primary key
#  name        :text
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Menu < ApplicationRecord
end
