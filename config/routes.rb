Rails.application.routes.draw do
  get 'welcome/tables'
  get 'welcome/diagram'

  resources :rangkings
  resources :kriteria
  resources :alternatifs
  root to: 'welcome#diagram'

end
