Calendar::Application.routes.draw do
  resources :tipo_usuarios

  devise_for :admins
  devise_for :usuarios


  resources :events
  resources :agendamentos
  resources :tipos

  match 'agendamento' => 'agendamento#index'
  match 'erro_criacao' => 'event#erro'
  match 'to_evento' => 'events#show_one'
  match 'escolha' => 'acessos#index'
  match 'sala_equipamento' => 'calendar#unico'
  match 'admin_novo_evento' => 'admin#new'
  match 'admin_evento_show' => 'admin#show'
  match 'login_devise' => 'login#calendario'
  match 'admin_eventos' => 'tipos#eventos'
  match 'admin_rejeita' => 'admin_event#rejeita'
  match 'admin_aceita' => 'admin_event#aceita'
  match 'ver_usuario' => 'admin#ver_usuarios'
  match 'permissoes' => 'admin#permissoes'
  match 'permitir' => 'tipo_usuarios#edit'
  match 'tirapermissao' => 'tipo_usuarios#destroy'
  match 'ver_dia' => 'events#ver_dia'
  match 'monta_relatorio' => 'events#monta_relatorio'
  match 'newindex' => 'events#newindex'
  match 'newindex_admin' => 'admin#newindex'
  match 'index_event' => 'events#index_event'
  match 'index_event_admin' => 'admin#index_event'
  match 'pre_form' => 'events#pre_form'
  get 'show_ags/:id' => 'events#show_ags', as: 'show_ags'
  get 'show_ags_admin/:id' => 'admin#show_ags', as: 'show_ags_admin'


  get 'tipodescricao/:tipo_id' => 'events#tipodescricao', :as => 'tipodescricao'

  get "calendar/index"

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
# root :to => "welcome#index"

 # root :to => "calendar#index"
  root :to => "events#redireciona"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
