class Unit < ActiveRecord::Base
  belongs_to :project

  def update_unit_data(results)
    results.each do |key, value|
      next if key == 'judgments'
      unit_data = UnitData.find_by_field_and_unit_id(key, self.id)
      if unit_data.nil?
        UnitData.create(field: key, value: value["agg"], unit_id: self.id, project_id: self.project_id)
      else
        unit_data.update_attributes(field: key, value: value["agg"])
      end
    end
  end

  def send_to_next_jobs(job_id)
    job_alias = client.jobs.find(job_id).alias
    next_jobs = project.rules.where(starting_job_id: job_alias).pluck(:ending_job_id)
    next_jobs.each do |job|
      client.units.create(job_id: job, data: format_data)
    end
  end

  def format_data
    unit_data = UnitData.where(unit_id: self.id)
    unit_data.each_with_object({}) do |data, hash|
      hash[data.field] = data.value
    end
  end

  def client
    @client ||= Crowdkit.new(access_token: "yLhxifNyfX6yvU2KDSS1", api_endpoint: "http://api.crowdflower.dev/v2")
  end
end