class Job < ActiveRecord::Base
  def percent_complete
    client.jobs.find(self.job_alias).stats(:percent_complete)
  rescue
    rand(0..100)
  end

  def self.format_percent_complete(aliases)
    aliases.each_with_object({}) do |job_alias, completion_hash|
      completion_hash[job_alias] = Job.find_by_alias(job_alias).percent_complete
    end
  end

  def client
    @client ||= Crowdkit.new(access_token: "VwGBjS71PjAgzZiD4sZj", api_endpoint: "https://api.sandbox.cf3.us/v2")
  end
end
