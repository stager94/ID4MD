Rails.application.routes.draw do
  scope :api, defaults: {format: :json} do
    scope :v1 do
      scope :doctors do

        devise_for :doctor, path: '', controllers: {
          sessions: 'api/v1/doctors/sessions',
          invitations: 'api/v1/doctors/invitations',
        }
        devise_scope :doctor do
          get '/current_user' => 'api/v1/doctors/sessions#get_current_user'
        end

      end
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :doctors do
        resources :doctors, path: 'profile', only: [:show, :update]
        resources :patients, only: [:index, :show, :update]

        resources :medical_profiles, only: [:show] do

          namespace :chat do
            resources :messages, only: [:index, :create]
          end

        end


      end
    end
  end
end
