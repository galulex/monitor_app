# Manage servers
class InstancesController < ApplicationController
  expose :instances, -> { Instance.all }
  expose :datapoint, lambda {
    instance.datapoints.last || instance.datapoints.build(disk: {})
  }
  expose :instance

  after_action :restream, only: [:create, :destroy]

  def create
    render(:new) && return unless instance.save
    redirect_to instance_path(instance), turbolinks: true
    restream
  end

  def destroy
    instance.destroy
    redirect_to root_path, turbolinks: true
  end

  private

  def instance_params
    params.require(:instance).permit(:name, :url, :token)
  end

  def restream
    MonitorTriggerJob.perform_now
  end
end
