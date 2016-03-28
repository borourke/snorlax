class Project < ActiveRecord::Base
  has_many :jobs
  has_many :units

  def self.format_json_for_index
    self.all.order(created_at: :desc).each_with_object({}) do |project, index_hash|
      index_hash[project.name] = project.jobs.each_with_object({}) do |job, jobs_hash|
        jobs_hash[job.alias.to_sym] = job.percent_complete
      end
    end
  end
end