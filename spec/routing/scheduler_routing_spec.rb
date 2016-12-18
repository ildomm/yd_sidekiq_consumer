# file: spec/routing/scheduler_routing_spec.rb
require 'rails_helper'

RSpec.describe SchedulerController, type: :routing do
  it { expect(get:    "/scheduler/stop").to      route_to("scheduler#stop") }
  it { expect(get:    "/scheduler/start").to     route_to("scheduler#start") }
  it { expect(get:    "/scheduler/run_now").to   route_to("scheduler#run_now") }
end

