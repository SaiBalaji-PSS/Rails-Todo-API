class Api::V1::TodosController < ApplicationController
  def get_all_todos
    # Query Parameters: {"completed" => "true", "priority" => "medium"}



      # If priority key is present the filter by priority
      # no need to convert the priority param string to int
      # rails will automatically map it to int using enum in model
    priority_query = params[:priority]
    #filter chain
    all_todos = TodoQueries.new(current_user.todos)
                           .filter_todo_by_priority(priority_query)
                           .filter_todo_by_completion(params[:completed])
                           .result






    render json: { todo: all_todos }, status: :ok
  end

  def get_todo_by_id
    begin
      matching_todo = current_user.todos.find(params[:id])
      render json: { todo: matching_todo }, status: :ok
    rescue => e
      render json: { message: e.message }, status: :ok
    end
  end

  def add_new_todo
    new_todo = current_user.todos.new(todo_params)
    puts params.inspect
    if new_todo.save
      render json: { message: "Added new todo", todo: new_todo }, status: :ok
    else
      render json: { message: new_todo.errors.full_messages.to_sentence }, status: :ok
    end
  end

  def update_todo
    begin
      matching_todo = current_user.todos.find(params[:id]) # id from /:id
      puts matching_todo
      if matching_todo.update(todo_params)
        render json: { message: "Todo updated successfuly", todo: matching_todo }, status: :ok
      end

    rescue => e
      render json: { message: e.message }, status: :ok
    end
  end

  def delete_todo_by_id
    begin
      matching_todo = current_user.todos.find(params[:id]) # id from /:id
      matching_todo.destroy
      render json: { message: "Deleted Todo successfully", todo: matching_todo }, status: :ok
    rescue => e
      render json: { message: e.message }, status: :ok
    end
  end

  def get_status
    completed_todo_count = current_user.todos.where({ completed: true })
    pending_todo_count = current_user.todos.where({ completed: false })
    render json: { completed: completed_todo_count.length, pending: pending_todo_count.length }, status: :ok
  end

  private
  def todo_params
    params.required(:todo).permit(:title, :description, :priority, :due_date, :completed)
  end
end
