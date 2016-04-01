class Job < ActiveRecord::Base
  def percent_complete
    client.jobs.find(self.alias).stats(:percent_complete)
  rescue
    { percent_complete: rand(0..100) }
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
      routes: []
    }
  end
end
