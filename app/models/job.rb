class Job < ActiveRecord::Base
  belongs_to :project

  def percent_complete
    client.jobs.find(self.alias).stats(:percent_complete)
  rescue
    { percent_complete: 0 }
  end

  def self.format_percent_complete(aliases)
    aliases.each_with_object({}) do |job_alias, completion_hash|
      completion_hash[job_alias] = Job.find_by_alias(job_alias).percent_complete
    end
  end

  def fields
    job = client.jobs.find(self.alias)
    job.quality_settings[:confidence_fields]
  end

  def client
    @client ||= Crowdkit.new(access_token: "5URrBpcuVXAqNAs263sg", api_endpoint: "http://api.sandbox.cf3.us/v2")
  end

  def flow
    {
      name: self.alias,
      x: self.x,
      y: self.y,
      start: self.starting_job,
      routes: project.rules.where(starting_job_id: self.alias).pluck(:ending_job_id, :operation).map do |rule|
        {
          name: rule[0],
          gate: rule[1]
        }
      end
    }
  end
end
