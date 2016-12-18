# file: spec/routing/scheduler_routing_spec.rb
require 'rails_helper'

describe StockWorker do
  it { is_expected.to be_processed_in :default }
  it { is_expected.to be_unique }

  it 'Enqueues job' do
    expect {
      StockWorker.perform_async(CommodityHistory::SEQUENCE)
    }.to change(StockWorker.jobs, :size).by(1)
  end

end