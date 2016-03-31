class RulesController < ApplicationController
  def new
    @rule = Rule.new
    @project = Project.find(params[:id])
    @rules = @project.rules
    @fields = @project.fields.flatten
    @operators = Rule.operators
  end

  def create
    Rule.create(rule_params)
    redirect_to project_path(params[:id])
  end

  private

  def rule_params
    params[:rule][:project_id] = params[:id]
    params.require(:rule).permit(:starting_job_id, :field, :project_id, :operation, :value, :ending_job_id)
  end
end
