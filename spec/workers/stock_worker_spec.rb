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
      end
    end
  end

  describe '.persist_error' do
    subject { stock_worker.persist_error(commodity, message) }
    context 'successful persist_error call' do
      let(:commodity) { Commodity.create(name: "abcd") }
      let(:message) { 'teste message' }
      it 'should PERSIST in database' do
        expect {
          subject
        }.to change(CommodityError, :count).by(1)
      end
    end
  end

  describe '.persist_quote' do
    subject { stock_worker.persist_quote(commodity, data) }
    context 'successful persist_quote call SEQUENCE' do
      let(:commodity) { Commodity.create(name: "abcd") }
      let(:data) { {last_trade_price: Faker::Number.number(10),
                    last_trade_date: Faker::Date.backward(0),
                    change: Faker::Number.number(10),
                    previous_close: Faker::Number.number(10),
                    update_type: CommodityHistory::SEQUENCE
      } }
      it 'should PERSIST in database' do
        expect {
          subject
        }.to change(CommodityHistory, :count).by(1)
      end
    end
    context 'successful persist_quote call UNIQUE' do
      let(:commodity) { Commodity.create(name: "abcd") }
      let(:data) { {last_trade_price: Faker::Number.number(10),
                    last_trade_date: Faker::Date.backward(0),
                    change: Faker::Number.number(10),
                    previous_close: Faker::Number.number(10),
                    update_type: CommodityHistory::UNIQUE
      } }
      it 'should PERSIST in database' do
        expect {
          subject
        }.to change(CommodityHistory, :count).by(1)
      end
    end
    context 'failure persist_quote call UNIQUE' do
      let(:commodity) { Commodity.create(name: "abcd") }
      let(:data) { {last_trade_price: 10.11,
                    last_trade_date: '2016-01-01 00:00:00',
                    change: Faker::Number.number(10),
                    previous_close: Faker::Number.number(10),
                    update_type: CommodityHistory::UNIQUE
      } }
      it 'should PERSIST ONCE in database' do
        expect {
          subject
        }.to change(CommodityHistory, :count).by(1)
        expect {
          subject
        }.to change(CommodityHistory, :count).by(0)
      end
    end
  end

end