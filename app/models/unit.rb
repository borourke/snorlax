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
    rules = project.rules.where(starting_job_id: job_alias)
    rules.each do |rule|
      if rule.unit_passes?(UnitData.where(unit_id: self.id))
        client.units.create(job_id: rule.ending_job_id, data: format_data)
      end
    end
  end

  def format_data
    unit_data = UnitData.where(unit_id: self.id)
    unit_data.each_with_object({}) do |data, hash|
      hash[data.field] = data.value
    end
  end

  def client
    @client ||= Crowdkit.new(access_token: "5URrBpcuVXAqNAs263sg", api_endpoint: "http://api.sandbox.cf3.us/v2")
  end
end