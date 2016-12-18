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

  let(:stock_worker) { StockWorker.new }
  describe '.perform' do
    subject { stock_worker.perform(params) }
    context 'successful SEQUENCE call' do
      let(:params) { 1 }
      it 'should call YahooFinance::Client' do
        expect(YahooFinance::Client).to receive(:new).and_call_original
        subject
      end
    end

    context 'successful UNIQUE call' do
      let(:params) { 2 }
      it 'should call YahooFinance::Client' do
        expect(YahooFinance::Client).to receive(:new).and_call_original
        subject
      end
    end

    context 'failure' do
      let(:params) { 3 }
      it 'should call YahooFinance::Client' do
        expect(YahooFinance::Client).to receive(:new).and_call_original
        subject
      end
    end
  end

  describe '.get_commodities' do
    before do
      commodity = Commodity.create(name: "abcd")
    end
    subject { stock_worker.get_commodities }
    context 'successful get_commodities call' do
      it 'should call retrieve ActiveRecord relation' do
        expect(subject.to_a.size).to eql(1)
        expect(subject.first).to be_instance_of(Commodity)
        subject
      end
    end
  end


end