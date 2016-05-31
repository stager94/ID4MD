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
        # resources :doctors, path: 'profile', only: :show do
        #   collection do
        #     post :invite_doctor
        #   end
        # end
      end
    end
  end
end
