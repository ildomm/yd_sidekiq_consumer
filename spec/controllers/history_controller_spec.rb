# file: spec/controllers/history_controller_spec.rb
require 'rails_helper'

RSpec.describe HistoryController, type: :controller do

  let(:valid_commodity_attributes) {
    [ { name: "abcd" },
      { name: "fght" },
      { name: "sstd" }
    ]
  }
  let!(:commodity) { Commodity.create(valid_commodity_attributes) }

  let(:valid_commodity_history_sequence_attributes) {
    [
                {
                    "id": 1,
                    "commodity_id": 3,
                    "last_trade_price": 1169.9,
                    "last_trade_date": "2016-11-30",
                    "change": 0,
                    "previous_close": 1169.9,
                    "update_type": 1,
                    "created_at": "2016-12-18 00:34:04",
                    "updated_at": "2016-12-18 00:34:04"
                },
                {
                    "id": 2,
                    "commodity_id": 1,
                    "last_trade_price": 16.14,
                    "last_trade_date": "2016-12-16",
                    "change": 0.18,
                    "previous_close": 15.96,
                    "update_type": 1,
                    "created_at": "2016-12-18 00:34:07",
                    "updated_at": "2016-12-18 00:34:07"
                },
                {
                    "id": 3,
                    "commodity_id": 2,
                    "last_trade_price": 16.153,
                    "last_trade_date": "2016-12-15",
                    "change": 0,
                    "previous_close": 16.153,
                    "update_type": 1,
                    "created_at": "2016-12-18 00:34:13",
                    "updated_at": "2016-12-18 00:34:13"
                }
    ]
  }
  let!(:commodity_histories_sequence) { CommodityHistory.create(valid_commodity_history_sequence_attributes) }

  let(:time_a) {Time.now.strftime("%Y-%m-%d %H:%M")}
  let(:time_b) { ( Time.now + 1.second ).strftime("%Y-%m-%d %H:%M")}
  let(:valid_commodity_history_unique_attributes) {
    [
        {
            "id": 4,
            "commodity_id": 3,
            "last_trade_price": 1169.9,
            "last_trade_date": "2016-11-30",
            "change": 0,
            "previous_close": 1169.9,
            "update_type": 2,
            "created_at": time_a,
            "updated_at": time_a
        },
        {
            "id": 5,
            "commodity_id": 1,
            "last_trade_price": 16.14,
            "last_trade_date": "2016-12-16",
            "change": 0.18,
            "previous_close": 15.96,
            "update_type": 2,
            "created_at": time_b,
            "updated_at": time_b
        },
    ]
  }
  let!(:commodity_histories_unique) { CommodityHistory.create(valid_commodity_history_unique_attributes) }
  let(:invalid_commodity_history_unique_attributes) {
    [
        {
            "id": 6,
            "commodity_id": 3,
            "last_trade_price": 1169.9,
            "last_trade_date": "2016-11-30",
            "change": 0,
            "previous_close": 1169.9,
            "update_type": 2,
            "created_at": "2016-12-18 00:34:13",
            "updated_at": "2016-12-18 00:34:13"
        },
    ]
  }
  let!(:commodity_histories_unique_invalid) { CommodityHistory.create(invalid_commodity_history_unique_attributes) }

  describe "GET #sequence" do
    it "assigns a newly created @commodity and histories SEQUENCE" do
      get :sequence, { format: :html }
      expect(assigns(:commodities)).to eq(commodity)
      expect(assigns(:last_update)).to eq("2016-12-18 00:34:13")
      expect(assigns(:errors)).to eq([])
    end
  end

  describe "GET #unique" do
    it "assigns a newly createdhistories UNIQUE" do
      get :unique, { format: :html }
      expect(assigns(:commodity_histories)).to eq(commodity_histories_unique)
      expect(assigns(:last_update)).to eq(time_b)
    end
  end

end