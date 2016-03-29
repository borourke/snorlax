class JobsController < ApplicationController
  def percent_complete
    aliases = params[:aliases]
    Job.format_percent_complete(aliases)
  end

  def show
    @project = Project.find(params[:id])
  end
end
