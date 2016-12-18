# file: spec/routing/history_routing_spec.rb
require 'rails_helper'

RSpec.describe HistoryController, type: :routing do
  it { expect(get:    "/history/sequence").to           route_to("history#sequence") }
  it { expect(get:    "/history/sequence_refresh").to   route_to("history#sequence_refresh") }
  it { expect(get:    "/history/unique").to             route_to("history#unique") }
  it { expect(get:    "/history/unique_refresh").to     route_to("history#unique_refresh") }
end

