Rails.application.routes.draw do

  scope :api, defaults: { format: :json } do
    scope :v1 do
      scope :patients do

        devise_for :patient, path: '', controllers: {
          sessions: 'api/v1/patients/sessions',
          invitations: 'api/v1/patients/invitations',
        }
        devise_scope :patient do
          get '/current_user' => 'api/v1/patients/sessions#get_current_user'
          get '/invitations/info/:token' => 'api/v1/patients/invitations#get_user_info'
        end

      end
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :patients do
        resources :patients, path: "dashboard" do
          collection do
            resources :medical_profiles, only: :show do
              member do
                resources :appointments, only: :index
                resources :visits, only: :index
                resources :diagnosises, only: :index
              end
            end
          end
        end
      end
    end
  end

end
