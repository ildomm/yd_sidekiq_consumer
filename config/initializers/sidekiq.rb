require 'sidekiq/scheduler'

# Set flags
Sidekiq::Scheduler.dynamic = true
Sidekiq::Scheduler.enabled = false

if ENV['RAILS_ENV'] != 'test'
  # Force reset status
  Sidekiq::Stats.new.reset
  Sidekiq::RetrySet.new.clear
  Sidekiq::ScheduledSet.new.clear

  # Force clear
  Sidekiq.redis { |conn| conn.flushdb }
  Sidekiq.redis { |conn| conn.flushall }
end

