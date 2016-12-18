# file: spec/routing/commodity_routing_spec.rb
require 'rails_helper'

RSpec.describe CommodityController, type: :routing do
  it { expect(get:    "/commodity/add/1").to route_to("commodity#add", id: "1") }
end
