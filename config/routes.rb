Rails.application.routes.draw do
  # we only have v1, so not using namespace for now
  scope :v1 do
    resource :noodle_venues, only: :show
    resources :tokens, only: :create
  end
end
