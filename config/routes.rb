Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'locations#new', as: 'new_location'
  post '/', to: 'locations#show', as: 'show_location'

  root "location#new", as: :dashboard 
end
