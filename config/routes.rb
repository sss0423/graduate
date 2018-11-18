Rails.application.routes.draw do
  resources :memos
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
