json.array! @projects do |project|
  json.extract! project, :id, :name, :created_at
    json.jobs do
      json.array! project.jobs do |job|
        json.extract! job, :id, :alias
        json.percent_complete job.percent_complete
      end
    end
end
