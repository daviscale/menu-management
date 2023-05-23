# == Schema Information
#
# Table name: menu_items
#
#  id          :bigint           not null, primary key
#  name        :text             not null
#  description :text
#  price       :decimal(10, 2)   not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  describe "#name" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(300) }
  end

  describe "#price" do
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to allow_value(0).for(:price) }
    it { is_expected.to allow_value(10.50).for(:price) }
    it { is_expected.to_not allow_value(-1).for(:price) }
  end

  describe "associations" do
    let(:menu_item) { FactoryBot.create(:menu_item) }

    it "belongs to Menu" do
      expect(menu_item.menu).to be_a Menu
    end
  end
end
