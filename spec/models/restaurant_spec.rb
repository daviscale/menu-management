# == Schema Information
#
# Table name: restaurants
#
#  id         :bigint           not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe "#name" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(300) }
  end

  describe "associations" do
    let(:restaurant) { FactoryBot.create(:restaurant) }
    let(:menu_0) { FactoryBot.create(:menu) }
    let(:menu_1) { FactoryBot.create(:menu) }
    let(:menu_2) { FactoryBot.create(:menu) }

    before do
      restaurant.menus << [menu_0, menu_1, menu_2]
    end

    it "has multiple Menus" do
      expect(restaurant.menus.size).to eq(3)
      expect(restaurant.menus[0]).to eq(menu_0)
      expect(restaurant.menus[1]).to eq(menu_1)
      expect(restaurant.menus[2]).to eq(menu_2)
    end
  end
end
