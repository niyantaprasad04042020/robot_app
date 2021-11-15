Rails.application.routes.draw do
  get "/robot/0/orders", to: "robots#orders"
end
