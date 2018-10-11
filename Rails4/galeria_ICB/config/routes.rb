Rails.application.routes.draw do



 # get 'tags/index'

  get 'welcome/login'
  get 'welcome/callback'

  get 'logout' => 'welcome#destroy', as: 'logout'

  get 'escolhe_capa/:id' => 'albuns#escolher_capa', as: 'escolhe_capa'
  get 'definir_capa/:id' => 'albuns#definir_capa', as: 'definir_capa'
  get 'mostrar/:id' => 'colecao#mostrar', as: 'mostrar'
  get 'busca_tag' => 'colecao#busca_tag', as: 'busca_tag'
  get 'resultado_busca_tag' => 'colecao#resultado_busca_tag', as: 'resultado_busca_tag'
  get 'pesquisa' => 'colecao#pesquisa', as: 'pesquisa'
  get 'repete_legenda' => 'albuns#repete_legenda', as: 'repete_legenda'

  resources :albuns
  resources :fotos
  resources :departamentos
  resources :categorias
  resources :colecao
  resources :tags
  resources :permitidos
  resources :perfils
  resources :logs
  resources :usuarios




  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".



  # You can have the root of your site routed with "root"
  root 'colecao#index'



  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
