Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/auth/signin", to: "auth#login"
      post "/auth/signup", to: "auth#create_user"
      get "/auth/getuser", to: "auth#get_user"
      delete "/auth/deleteuser", to: "auth#delete_user"

      get "/status", to: "todos#get_status"
      get "/todo/", to: "todos#get_all_todos" # todos is controller name
      get "/todo/:id", to: "todos#get_todo_by_id"
      post "/todo/", to: "todos#add_new_todo"
      patch "/todo/:id", to: "todos#update_todo"
      delete "todo/:id", to: "todos#delete_todo_by_id"
    end
  end
end
