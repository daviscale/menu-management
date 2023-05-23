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
require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe "#name" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(300) }
  end

  describe "associations" do
    let(:menu) { FactoryBot.create(:menu) }

    it "has multiple MenuItems" do
      expect(menu.menu_items.size).to eq(10)
    end

    it "belongs to Restaurant" do
      expect(menu.restaurant).to be_a Restaurant
    end
  end
end
