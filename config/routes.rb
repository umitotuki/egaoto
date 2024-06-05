Rails.application.routes.draw do
 devise_for :users, skip: [:passwords], controllers: {
   registrations: "public/registrations",
  sessions: 'public/sessions'
 }
  # devise_for :admins, skip: [:registrations, :passwords], controllers: {
  #   sessions: "admin/sessions"
  # }
 
  namespace :public do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
    get 'users/confirm'
    get 'users/mypage'
  end
   
  namespace :public do
    get 'chats/show'
  end
  namespace :public do
    get 'posts/new'
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  namespace :admin do
    get 'genres/index'
    get 'genres/edit'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
  end
  namespace :admin do
    get 'posts/index'
    get 'posts/show'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
