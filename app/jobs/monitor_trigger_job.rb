class MonitorTriggerJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    `ruby #{Rails.root}/lib/monitor_control.rb restart`
  end
end
