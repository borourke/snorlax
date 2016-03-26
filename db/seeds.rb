akon_id = "1"
project_names = ["International Cat", "Tag Images", "Bomb Ass Project", "Hack Day"]

project_names.each do |project_name|
  Project.create(name: project_name, akon_id: akon_id)
end
