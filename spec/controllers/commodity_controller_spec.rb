# file: spec/controllers/commodity_controller_spec.rb
require 'rails_helper'

RSpec.describe CommodityController, type: :controller do

  before do
    commodity = Commodity.create(name: "abcd")
  end

  describe "GET #run_now" do
    it "add new commodity" do
      expect {
        get :add, { id: "bcc" }, { format: :html }
      }.to change(Commodity, :count).by(1)
      expect(response.status).to eq(302)
    end
  end

end