Rails.application.routes.draw do
  resources :staffs
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/schedules/:staff_id", to: "schedules#index"
  get "/staffs", to: "staffs#index"
end
