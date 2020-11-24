Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/about'
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :posts do
    post   '/like/:id' => 'likes#post_like',   as: 'like'
    delete '/like/:id' => 'likes#post_unlike', as: 'unlike'
    post   '/comment/:id' => 'comments#post_create',   as: 'create_comment'
    delete '/comment/:id' => 'comments#post_destroy', as: 'destroy_comment'
  end
  resources :questions do
    post   '/like/:id' => 'likes#question_like',   as: 'like'
    delete '/like/:id' => 'likes#question_unlike', as: 'unlike'
    post   '/comment/:id' => 'comments#question_create',   as: 'create_comment'
    delete '/comment/:id' => 'comments#question_destroy', as: 'destroy_comment'
  end
end
