Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root "subscribers#new"
    resources :subscribers, only: %i[index create new]
  end
end
