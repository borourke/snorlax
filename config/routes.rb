Rails.application.routes.draw do
  root 'projects#index'

  # Projects
  get 'projects' => 'projects#index'
  get 'projects/:id' => 'projects#show', as: :project
  get 'projects/new' => 'projects#new'
  post 'projects/create' => 'projects#create'

  get 'project_progress' => 'projects#get_progress'

  get 'projects/:id/datasets/new' => 'projects#new_dataset', as: :new_dataset
  post 'projects/:id/datasets/new' => 'projects#create_dataset'

  # Jobs
  get 'projects/:id/jobs/new' => 'jobs#new'
  post 'projects/:id/jobs/new' => 'jobs#create'

  # Rules
  get 'projects/:id/rules/new' => 'rules#new', as: :new_rule
  post 'projects/:id/rules/new' => 'rules#create', as: :create_rule

  # Incoming units
  post 'unit_completion' => 'webhooks#receive_units', as: :receive_units
end
