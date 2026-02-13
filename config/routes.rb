Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/todo/", to: "todos#get_all_todos" #todos is controller name
      get "/todo/:id", to: "todos#get_todo_by_id"
      post "/todo/", to: "todos#add_new_todo"
      patch "/todo/:id", to: "todos#update_todo"
      delete "todo/:id", to: "todos#delete_todo_by_id"
    end
  end
end
