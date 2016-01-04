Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount PostgresqlLoStreamer::Engine => "/picture_image"
  devise_for :users, controllers: { registrations: 'registrations' }

  devise_scope :user do
    authenticated :user do
      root 'users#show_profile', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  get '/profile', to: 'users#show_profile'

  get '/veterinarian_appointments', to: 'appointments#veterinarian_appointments'
  get '/veterinarian_appointment/:id', to: 'appointments#veterinarian_appointment', as: 'veterinarian_appointment'
  get '/veterinarian_appointment/:id/edit', to: 'appointments#veterinarian_edit_appointment', as: 'edit_veterinarian_appointment'
  patch '/veterinarian_appointment/:id/update', to: 'appointments#veterinarian_update_appointment', as: 'update_veterinarian_appointment'
  patch '/veterinarian_appointment_cancel/:id', to: 'appointments#veterinarian_appointment_cancel', as: 'veterinarian_cancel'
  patch '/veterinarian_appointment_accept/:id', to: 'appointments#veterinarian_appointment_accept', as: 'veterinarian_accept'

  #Static pages
  get '/help_page', to: 'static_pages#help_page'
  get '/about', to: 'static_pages#about'

  #Dictionaries
  get '/dictionaries', to: 'static_pages#dictionaries'
  get '/units_search', to: 'static_pages#units_search'
  get '/species_search', to: 'static_pages#species_search'
  get '/diseases_search', to: 'static_pages#diseases_search'
  get '/treatments_search', to: 'static_pages#treatments_search'

  resources :units, only: [ :new, :create, :edit, :update ]
  resources :diseases, only: [ :new, :create, :edit, :update ]
  resources :treatments, only: [ :index, :new, :create, :edit, :update ]
  resources :species, only: [ :new, :create, :edit, :update ]

  resources :veterinarians, only: [ :index ]

  resources :users, only: [ :index, :show, :new, :create, :edit, :update ] do
    get '/veterinarians', to: 'veterinarians#index_veterinarians'
    get '/veterinarians/:id/calendar', to: 'veterinarians#show_calendar', as: 'veterinarian_calendar'

    resources :animals, only: [ :index, :show, :new, :create, :edit, :update ]
    resources :medical_records, only: [ :index, :show, :new, :create, :edit, :update ]
    resources :pictures, only: [ :index, :show, :new, :create, :edit, :update ]
    resources :appointments, only: [ :index, :show, :new, :create, :edit, :update ] do
      patch '/cancel', to: 'appointments#cancel'
    end
  end
end
