Rails.application.routes.draw do
  root 'projects#index'

  # Jobs
  get 'projects' => 'projects#index'
  get 'projects/:id' => 'projects#show', as: :project
  get 'projects/new' => 'projects#new'
  post 'projects/create' => 'projects#create'
  get 'projects/:id/datasets/new' => 'projects#new_dataset', as: :new_dataset
  post 'projects/:id/datasets/new' => 'projects#create_dataset'

  # Takes an array of job_ids as a params object, to be used in controller
  get 'jobs/percent_complete' => 'jobs#percent_complete'
  get 'jobs/new' => 'jobs#new'
end
