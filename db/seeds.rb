puts "Starting seeding..."

akon_id = "1"
project_names = ["International Cat", "Tag Images", "Bomb Ass Project", "Hack Day"]
jobs = {
  int_cat_job_aliases: [
    {alias: :intcat1, x: 200, y: 200},
    {alias: :intcat2, x: 400, y: 100},
    {alias: :intcat3, x: 500, y: 300}
  ],
  tag_images_job_aliases: [
    {alias: :tagimages1, x: 200, y: 200},
    {alias: :tagimages2, x: 400, y: 200}
  ],
  bomb_ass_job_aliases: [
    {alias: :bombass1, x: 200, y: 200},
    {alias: :bombass2, x: 400, y: 100},
    {alias: :bombass3, x: 500, y: 300}
  ],
  hack_day_job_aliases: [
    {alias: :hackday1, x: 200, y: 200},
    {alias: :hackday2, x: 400, y: 100},
    {alias: :hackday3, x: 500, y: 300}
  ],
}

project_names.each do |project_name|
  Project.create(name: project_name, akon_id: akon_id)
end

counter = 0
%w(int_cat_job_aliases tag_images_job_aliases bomb_ass_job_aliases hack_day_job_aliases).each do |array|
  counter += 1
  jobs[array.to_sym].each do |job|
    Job.create(alias: job[:alias], akon_id: akon_id, job_type: "cf_job", project_id: counter, starting_job: true, x: job[:x], y: job[:y])
  end
end

puts "Done seeding!"
