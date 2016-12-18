class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :load_status

  def load_status
    @schedule_status = Sidekiq::Scheduler.enabled
  end
end
