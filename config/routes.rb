Rails.application.routes.draw do
  
  post 'signup', to: 'users#create'
  post 'auth/login', to: 'authentication#authenticate'

  resources :jobs, only: [:create]
  get '/available-jobs', to: "jobs#available_jobs"
  post '/claim-job', to: "jobs#claim_job"
  post '/execute-job', to: "jobs#execute_job"
  get '/all-jobs', to: "jobs#all_jobs"
  post '/show-job', to: "jobs#show_job"
  get '/my-jobs', to: "jobs#my_jobs"
end