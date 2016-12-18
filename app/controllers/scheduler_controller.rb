class SchedulerController < ApplicationController

  def run_now
    worker = StockWorker.new
    worker.perform(CommodityHistory::SEQUENCE)
    worker.perform(CommodityHistory::UNIQUE)

    redirect_to controller: :history, action: :sequence
  end

  def stop
    Sidekiq::Scheduler.enabled = false
    Sidekiq::Scheduler.clear_schedule!

    redirect_to controller: :history, action: :sequence
  end

  def start
    Sidekiq::Scheduler.enabled = true
    Sidekiq.set_schedule(
        'Stock check between minutes',
        {
            class: 'StockWorker',
            cron: ::StockMonitor::ApplicationConfig::WORKER_SCHEDULE_CRON_MINUTE,
            args: CommodityHistory::SEQUENCE,
            queue: 'default',
            description: 'Stock updater job between minutes'
        }
    )
    Sidekiq.set_schedule(
        'Stock check between hours',
        {
            class: 'StockWorker',
            cron: ::StockMonitor::ApplicationConfig::WORKER_SCHEDULE_CRON_HOUR,
            args: CommodityHistory::UNIQUE,
            queue: 'default',
            description: 'Stock updater job between hours'
        }
    )
    Sidekiq::Scheduler.reload_schedule!

    redirect_to controller: :history, action: :sequence
  end
end
