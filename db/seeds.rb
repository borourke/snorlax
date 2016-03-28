puts "Starting seeding..."

akon_id = "1"
project_names = ["International Cat", "Tag Images", "Bomb Ass Project", "Hack Day"]
job_aliases = {
  int_cat_job_aliases: [:int_cat1, :int_cat2, :int_cat3],
  tag_images_job_aliases: [:tag_images1, :tag_images2],
  bomb_ass_job_aliases: [:bomb_ass1, :bomb_ass2, :bomb_ass3],
  hack_day_job_aliases: [:hack_day1, :hack_day2, :hack_day3]
}

project_names.each do |project_name|
  Project.create(name: project_name, akon_id: akon_id)
end

counter = 0
%w(int_cat_job_aliases tag_images_job_aliases bomb_ass_job_aliases hack_day_job_aliases).each do |array|
  counter += 1
  job_aliases[array.to_sym].each do |job_alias|
    Job.create(alias: job_alias, akon_id: akon_id, job_type: "cf_job", project_id: counter)
  end
end

puts "Done seeding!"