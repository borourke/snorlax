class ProjectsController < ApplicationController
  def index
    @projects = Project.all.order(updated_at: :desc)
  end

  def show
    @project = Project.find(params[:id])
  end
end
