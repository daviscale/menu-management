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

  describe "associations" do
    let(:menu) { FactoryBot.create(:menu) }
    let(:menu_item_0) { FactoryBot.create(:menu_item) }
    let(:menu_item_1) { FactoryBot.create(:menu_item) }
    let(:menu_item_2) { FactoryBot.create(:menu_item) }

    before do
      menu.menu_items << menu_item_0
      menu.menu_items << menu_item_1
      menu.menu_items << menu_item_2
    end

    it "has multiple MenuItems" do
      expect(menu.menu_items.size).to eq(3)
      expect(menu.menu_items[0]).to eq(menu_item_0)
      expect(menu.menu_items[1]).to eq(menu_item_1)
      expect(menu.menu_items[2]).to eq(menu_item_2)
    end
  end
end
