Rails.application.routes.draw do
  get "/", to: "reserve#home"
  get "/reserve/search", to: "reserve#search"
  get "/reserve/staffs", to: "reserve#staff_all"
  get "/reserve/staff/:staff_id", to: "reserve#schedule"
  get "/reserve/staff/:staff_id/confirm", to: "reserve#confirm"
  post "/reserve/staff/:staff_id", to: "reserve#create_reservation"
  post "/staffs/import", to: "staffs#import"
end
