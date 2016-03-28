class Job < ActiveRecord::Base
  def percent_complete
    client = Crowdkit.new(access_token: "VwGBjS71PjAgzZiD4sZj", api_endpoint: "https://api.sandbox.cf3.us/v2")
    client.jobs.find(self.job_alias).stats(:percent_complete)
  rescue
    0
  end
end