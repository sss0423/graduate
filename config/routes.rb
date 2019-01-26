Rails.application.routes.draw do
  root 'tops#top'
  #devise_for :users
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end

  resources :memos

  mount LetterOpenerWeb::Engine, at: "/letter_opener"

#  if Rails.env.development?
#sendgrid凍結解除できるまでletteropenerで登録作業    
#  end
end
