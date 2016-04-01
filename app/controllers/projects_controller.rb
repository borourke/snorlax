class ProjectsController < ApplicationController

  def index
  end

  def project_status
    respond_to do |format|
      format.json { @projects = Project.includes(:jobs).all }
    end
  end

  def show
    @project = Project.find(params[:id])
    @jobs = @project.jobs
    @rules = @project.rules
    @rule = Rule.new
    @fields = @project.fields.flatten
    @operators = Rule.operators
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
    params.require(:project).permit(:name, :akon_id)
  end
end
