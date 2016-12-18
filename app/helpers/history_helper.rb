module HistoryHelper

  def get_worker_schedule_cron_minute
    ::StockMonitor::ApplicationConfig::WORKER_SCHEDULE_CRON_MINUTE
  end

  def get_worker_schedule_cron_hour
    ::StockMonitor::ApplicationConfig::WORKER_SCHEDULE_CRON_HOUR
  end

end
