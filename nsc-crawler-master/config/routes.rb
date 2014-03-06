Crawler::Application.routes.draw do

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

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'main#index'

  # See how all your routes lay out with "rake routes"
  match '/main/index'               => 'main#index',               :as => :main_index

  match '/category/list'            => 'main#category_list',       :as => :category_list
  match '/category/destroy'         => 'main#category_destroy',    :as => :category_destroy
  match '/category/wait'            => 'main#category_wait',       :as => :category_wait
  match '/category/wait_query'      => 'main#category_wait_query', :as => :category_wait_query
  match '/category/task_log'        => 'main#category_task_log',   :as => :category_task_log

  match '/article/read/:id'         => 'main#article_read',        :as => :article_read

  match '/main/grab_by_keyword'     => 'main#grab_by_keyword',     :as => :main_grab_by_keyword
  match '/main/grab_all_macrolevel' => 'main#grab_all_macrolevel', :as => :main_grab_all_macrolevel
  match '/main/grab_by_macrolevel'  => 'main#grab_by_macrolevel',  :as => :main_grab_by_macrolevel

  match '/keyword/control'          => 'main#keyword_control',     :as => :keyword_control
  match '/macrolevel/control'       => 'main#macrolevel_control',  :as => :macrolevel_control
  match '/kmw/control'              => 'main#kmw_control',         :as => :kmw_control

  match 'gcm/push'   => 'gcm#push',   :as => :gcm_push
  match 'gcm/list'   => 'gcm#list',   :as => :gcm_list
  match 'gcm/clear'  => 'gcm#clear',  :as => :gcm_clear
  match 'gcm/delete' => 'gcm#delete', :as => :gcm_delete
  match 'gcm/reg'    => 'gcm#reg',    :as => :gcm_reg

  match 'hadoop_trigger/index'   => 'hadoop_trigger#index',   :as => :hadoop_trigger_index
  match 'hadoop_trigger/request' => 'hadoop_trigger#request', :as => :hadoop_trigger_request

  match 'export/index'    => 'export#index',    :as => :export_index
  match 'export/category' => 'export#category', :as => :export_category
  match 'export/keyword'  => 'export#keyword',  :as => :export_keyword
  match 'export/all'      => 'export#all',      :as => :export_all
  match 'export/success'  => 'export#success',  :as => :export_success

  match 'import/kmw'      => 'main#import_kmw', :as => :import_kmw

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'


end
