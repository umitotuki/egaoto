Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
     sessions: "admin/sessions"
   }

 devise_for :users, skip: [:passwords], controllers: {
   registrations: 'public/registrations',
  sessions: 'public/sessions'
 }

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    get 'search' => 'searches#search', as: 'search'

    resources :posts, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:destroy]
    end
    resources :users, only: [:index, :show, :edit, :destroy]
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
  end

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'
    get 'users/mypage' => 'users#mypage', as: 'mypage'
    get 'users/confirm' => 'users#confirm'
    get 'search' => 'searches#search', as: 'search'
    get 'genre/search' => 'searches#genre_search' , as: 'genre_search'

    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
        get '/followings' => 'relationships#followings', as: 'followings'
        get '/followers' => 'relationships#followers', as: 'followers'
        
        member do
          get :favorite_posts
        end
    end

    resources :posts do
      resource :favorites, only: [:index, :create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end

    resources :chats, only: [:show, :create, :destroy]
  end

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
end
