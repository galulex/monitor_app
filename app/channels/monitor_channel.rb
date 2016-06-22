# Channell to stream server info
class MonitorChannel < ApplicationCable::Channel
  def subscribed
    stream_from "monitor_#{params[:instance_id]}"
  end

  def unsubscribe
  end
end
