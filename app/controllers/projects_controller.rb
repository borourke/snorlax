class ProjectsController < ApplicationController
  def index
    @projects = Project.format_json_for_index.map{ |project| {project.first => project.second}}
  end
end