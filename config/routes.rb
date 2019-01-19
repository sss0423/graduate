Rails.application.routes.draw do
  root 'tops#top'
  devise_for :users

  resources :memos

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
