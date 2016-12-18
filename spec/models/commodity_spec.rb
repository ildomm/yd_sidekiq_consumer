# file: spec/models/commodity_spec.rb
require 'rails_helper'
require 'shoulda-matchers'
require 'shoulda/matchers'

RSpec.describe Commodity, type: :model do

  describe "db structure" do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_index(:name) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it "is not valid without a title" do
      comm = Commodity.new(name: nil)
      expect(comm).to_not be_valid
    end
  end

  describe "associations" do
    it { is_expected.to have_many(:commodity_histories) }
    it { is_expected.to have_many(:commodity_errors) }
  end


end