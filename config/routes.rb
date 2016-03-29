Rails.application.routes.draw do
  root 'projects#index'

  get 'projects' => 'projects#index'
  get 'projects/new' => 'projects#new'
  post 'projects/create' => 'projects#create'

  # Takes an array of job_ids as a params object, to be used in controller
  get 'jobs/percent_complete' => 'jobs#percent_complete'
end
