class Api::V1::TodosController < ApplicationController
  def get_all_todos
    render json: {message: "Gettting all todos."}, status: :ok
  end

  def get_todo_by_id
    render json: {message: "Getting todo by id"}, status: :ok
  end

  def add_new_todo
    render json: {message: "Adding new todo"}, status: :created
  end

  def update_todo
    render json: {message: "Updating todo by id"}, status: :ok
  end

  def delete_todo_by_id
    render json: {message: "Deleting todo by id"}, status: :ok
  end
end
