class ProjectsController < ApplicationController
  def index
    @projects = Project.all.order(updated_at: :desc)
  end
end