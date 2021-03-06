require 'csv'

class Project < ActiveRecord::Base
  has_many :jobs
  has_many :unit_data
  has_many :rules

  def fields
    jobs.each_with_object([]) do |job, array|
      array << job.fields
    end
  end

  def generate_report
    unit_data = UnitData.where(project_id: self.id)
    units = Hash.new { |hash, key| hash[key] = {} }
    unit_data = unit_data.as_json
    headers = unit_data.first.keys
    CSV.open("/Users/borourke/Desktop/snorlax_report.csv", "w", headers: headers, write_headers: true) do |out|
      unit_data.each do |data|
        out << data.values
      end
    end
  end

  def upload_data(file_path)
    starting_jobs = jobs.where(starting_job: true)
    CSV.foreach(file_path, headers: true) do |row|
      unit = Unit.create(project_id: id)
      data = {}
      row.each do |column, value|
        data[column] = value
        UnitData.create(field: column, value: value, project_id: id, unit_id: unit.id)
      end
      data.merge!({snorlax_unit_id: unit.id})
      starting_jobs.each do |job|
        client.units.create(job_id: job.alias, data: data)
      end
    end
  end

  def client
    @client ||= Crowdkit.new(access_token: "5URrBpcuVXAqNAs263sg", api_endpoint: "http://api.sandbox.cf3.us/v2")
  end
end
