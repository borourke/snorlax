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
    Job.create(jobs_params)
    redirect_to project_path(params[:id])
  end

  private

  def jobs_params
    params[:job][:project_id] = params[:id]
    params.require(:job).permit(:alias, :project_id, :x, :y, :starting_job)
  end
end
