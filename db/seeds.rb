puts "Starting seeding..."

akon_id = "1"
project_names = ["International Cat", "Tag Images", "Bomb Ass Project", "Hack Day"]
job_aliases = {
  int_cat_job_aliases: [:intcat1, :intcat2, :intcat3],
  tag_images_job_aliases: [:tagimages1, :tagimages2],
  bomb_ass_job_aliases: [:bombass1, :bombass2, :bombass3],
  hack_day_job_aliases: [:hackday1, :hackday2, :hackday3]
}

project_names.each do |project_name|
  Project.create(name: project_name, akon_id: akon_id)
end

counter = 0
%w(int_cat_job_aliases tag_images_job_aliases bomb_ass_job_aliases hack_day_job_aliases).each do |array|
  counter += 1
  job_aliases[array.to_sym].each do |job_alias|
    Job.create(alias: job_alias, akon_id: akon_id, job_type: "cf_job", project_id: counter, starting_job: true)
  end
end

puts "Done seeding!"