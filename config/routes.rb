Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'application#doctors'
  get 'iphone6' => 'application#iphone6'
  get 'demo' => 'application#demo'

  # get '/application' => 'assets#application'

  get '/doctors' => 'application#doctors'
  get '/patients' => 'application#patients'
end

load Rails.root.join 'config/routes/api/doctors.rb'
load Rails.root.join 'config/routes/api/patients.rb'
