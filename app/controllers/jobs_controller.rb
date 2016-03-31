class JobsController < ApplicationController
  def percent_complete
    aliases = params[:aliases]
    Job.format_percent_complete(aliases)
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def create

  end

  private

  def jobs_params
    params[:job][:project_id] = params[:id]
    params.require(:job).permit(:alias)
  end
end
