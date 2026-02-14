class Api::V1::TodosController < ApplicationController
  def get_all_todos
    # Query Parameters: {"completed" => "true", "priority" => "medium"}
    all_todos = Todo.all

    if params.key?(:priority)
      # If priority key is present the filter by priority
      # no need to convert the priority param string to int
      # rails will automatically map it to int using enum in model
      priority_query = params[:priority]
      matching_todo = all_todos.where({ priority: priority_query })
      all_todos = matching_todo
    end

    if params.key?(:completed)
      completed_query = ActiveModel::Type::Boolean.new.cast(params[:completed])
      matching_todo = all_todos.where({ completed: completed_query })
      all_todos = matching_todo
    end

    render json: { todo: all_todos }, status: :ok
  end

  def get_todo_by_id
    begin
      matching_todo = Todo.find(params[:id])
      render json: { todo: matching_todo }, status: :unprocessable_entity
    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
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
    begin
      matching_todo = Todo.find(params[:id]) # id from /:id
      puts matching_todo
      if matching_todo.update(todo_params)
        render json: { message: "Todo updated successfuly", todo: matching_todo }, status: :ok
      end

    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  def delete_todo_by_id
    begin
      matching_todo = Todo.find(params[:id]) # id from /:id
      matching_todo.destroy
      render json: { message: "Deleted Todo successfully", todo: matching_todo }, status: :ok
    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  def get_status
    completed_todo_count = Todo.where({ completed: true })
    pending_todo_count = Todo.where({ completed: false })
    render json: { completed: completed_todo_count.length, pending: pending_todo_count.length }, status: :ok
  end

  private
  def todo_params
    params.required(:todo).permit(:title, :description, :priority, :due_date, :completed)
  end
end
