# file: spec/models/commodity_error_spec.rb
require 'rails_helper'

RSpec.describe CommodityError, type: :model do

  describe "db structure" do
    it { is_expected.to have_db_column(:commodity_id).of_type(:integer) }
    it { is_expected.to have_db_column(:message).of_type(:string) }

    it { is_expected.to have_db_index(:commodity_id) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:commodity) }
  end

end