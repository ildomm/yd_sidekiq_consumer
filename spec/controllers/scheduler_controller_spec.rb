# file: spec/controllers/scheduler_controller_spec.rb
require 'rails_helper'

RSpec.describe SchedulerController, type: :controller do

  describe "GET #stop" do
    it "stop worker collector" do
      get :stop, { format: :html }
      expect(Sidekiq::Scheduler.enabled).to eq(false)
      expect(Sidekiq::Scheduler.scheduled_jobs.size).to eq(0)
      expect(response.status).to eq(302)
    end
  end

  describe "GET #start" do
    it "start worker collector" do
      get :start, { format: :html }
      expect(Sidekiq::Scheduler.enabled).to eq(true)
      expect(Sidekiq::Scheduler.scheduled_jobs.size).to eq(2)
      expect(response.status).to eq(302)
    end
  end


  before do
    # valid
    commodity = Commodity.create(name: "abcd")
    # invalid
    commodity = Commodity.create(name: "xxxzzzyyyccc")
  end

  describe "GET #run_now" do
    it "run_now worker" do
      expect {
        get :run_now, { format: :html }
      }.to change(CommodityHistory, :count).by(2)
       .and change(CommodityError, :count).by(2)

      expect(response.status).to eq(302)
    end
  end

end