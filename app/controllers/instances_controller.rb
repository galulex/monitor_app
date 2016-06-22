# Manage servers
class InstancesController < ApplicationController
  expose :instances, -> { Instance.all }
  expose :datapoint, lambda {
    instance.datapoints.last || instance.datapoints.build(disk: {})
  }
  expose :instance

  def create
    if instance.save
      redirect_to instance_path(instance), turbolinks: true
      MonitorTriggerJob.perform_now
    else
      render :new
    end
  end

  def destroy
    MonitorTriggerJob.perform_now if instance.destroy
    redirect_to root_path, turbolinks: true
  end

  private

  def instance_params
    params.require(:instance).permit(:name, :url, :token)
  end
end
