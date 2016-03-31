class ProjectsController < ApplicationController
  def index
    @projects = Project.format_json_for_index.map { |project| { project.first => project.second } }
  end

  def get_progress
    render json: Project.format_json_for_index.map { |project| { project.first => project.second } }
  end

  def show
    @project = Project.find(params[:id])
    @jobs = @project.jobs
    @rules = @project.rules
  end

  def new
    @project = Project.new
  end

  def create
    Project.create(projects_params)
    redirect_to root_path
  end

  def new_dataset
    @dataset = Dataset.new
  end

  def create_dataset
    project = Project.find(params[:id])
    project.upload_data(params[:dataset][:file_path])
    redirect_to project_path(project.id)
  end

  private

  def projects_params
    params.permit(:name, :akon_id)
  end
end
