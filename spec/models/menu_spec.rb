# == Schema Information
#
# Table name: menus
#
#  id          :bigint           not null, primary key
#  name        :text             not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe "#name" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(300) }
  end
end
