class Api::V1::TodosController < ApplicationController
  def get_all_todos
    render json: { message: "Gettting all todos." }, status: :ok
  end

  def get_todo_by_id
    render json: { message: "Getting todo by id" }, status: :ok
  end

  def add_new_todo
    new_todo = Todo.new(todo_params)
    puts params.inspect
    if new_todo.save
      render json: { message: "Added new todo", todo: new_todo }, status: :ok
    else
      render json: { error: new_todo.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def update_todo
    render json: { message: "Updating todo by id" }, status: :ok
  end

  def delete_todo_by_id
    render json: { message: "Deleting todo by id" }, status: :ok
  end

  private
  def todo_params
    params.required(:todo).permit(:title, :description, :priority, :due_date, :completed)
  end
end
