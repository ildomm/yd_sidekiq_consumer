Rails.application.routes.draw do

  root :to => "history#sequence"

  controller :scheduler do
    get 'scheduler/stop'
    get 'scheduler/start'
    get 'scheduler/run_now'
  end

  controller :history do
    get 'history/sequence'
    get 'history/sequence_refresh'
    get 'history/unique'
    get 'history/unique_refresh'
  end

  controller :commodity do
    get 'commodity/add/:id' => 'commodity#add'
  end
  resources :commodity do
    collection do
      get :add
    end
  end

end

