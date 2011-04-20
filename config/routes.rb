EmoteRor::Application.routes.draw do
  devise_for :admins, :path => "/admin", :path_names => { :sign_in => 'login', :sign_out => 'logout' }

  devise_for :users, :path => "/", :controllers => { :sessions => "user_sessions", :confirmations => "user_confirmations", :registrations => "user_registrations" },
                                   :path_names => { :sign_in => 'login', :sign_out => 'logout', :registration => '/', :sign_up => 'register' }
  resource :account, :only => [:edit, :update] do
    resources :subscriptions, :except => [:create] do
      collection do
        post 'upgrade_to/:target_plan' => 'subscriptions#create', :as => :create
        get 'paypal_success'
        get 'paypal_cancel'
      end
    end
    resources :surveys do
      member do
        get 'scorecard'
        delete 'recreate'
      end
      resource :survey_results do
        collection do
          get 'charts'
          get 'verbatims'
          get 'delete_response'
        end
      end
    end
  end
  
  get 'scorecard/:code', :controller => 'surveys', :action => 'public_scorecard', :as => :public_scorecard
  
  namespace :admin do
    resources :accounts do
      member do
        post 'add_note'
      end
    end
    resources :emotes do
      collection do
        get 'refresh_counters'
      end
      member do
        get 'scorecard'
      end
    end
    resources :subscriptions, :except => [:destroy]
    root :to => "base#index"
  end
  

  #All-purpose thingy
  #match ':controller(/:action(/:id(.:format)))'
  
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "surveys#index"

  # devise
  # => register
  # => login
  # => confirm
  # => restore
  # => edit user info
  #
  # surveys (emotes)
  # => index
  # => create
  # => edit -- not now
  # => scorecard
  # => public scorecard
  #
  # subscriptions
  # => index
  # => create (number of emotes for 1 year)
  # => paypal_success
  # => paypal_cancel

  #home
  #  register
  #  e.mote control
  #    account admin
  #    users and permissions
  #    subscriptions
  #    e-commerce
  #  scorecard
  #  create/edit emote
    
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
