class ProjectsController < ApplicationController
  def index
    @projects = Project.format_json_for_index.map { |project| { project.first => project.second } }
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    p projects_params
    Project.create(projects_params)
    redirect_to root_path
  end

  private

  def projects_params
    params.permit(:name, :akon_id)
  end
end
