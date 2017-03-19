Rails.application.routes.draw do
  resources :materia
  get 'welcome/tables'
  get 'welcome/diagram'
  get 'error', to: 'error#index'

  resources :rangkings
  resources :kriteria
  resources :alternatifs
  root to: 'welcome#diagram'

end
