# file: spec/models/commodity_history_spec.rb
require 'rails_helper'

RSpec.describe CommodityHistory, type: :model do

  describe "db structure" do
    it { is_expected.to have_db_column(:commodity_id).of_type(:integer) }
    it { is_expected.to have_db_column(:last_trade_price).of_type(:float) }
    it { is_expected.to have_db_column(:last_trade_date).of_type(:date) }
    it { is_expected.to have_db_column(:change).of_type(:float) }
    it { is_expected.to have_db_column(:previous_close).of_type(:float) }
    it { is_expected.to have_db_column(:update_type).of_type(:integer) }

    it { is_expected.to have_db_index(:commodity_id) }
    it { is_expected.to have_db_index(:update_type) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:commodity) }
  end

end