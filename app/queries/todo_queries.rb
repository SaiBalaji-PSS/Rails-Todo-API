class TodoQueries
  def initialize(todos = Todo.all)
    @todos = todos
  end
  # A chainable method must always return self.
  def filter_todo_by_priority(priority)
     return self if priority.nil?
     @todos = @todos.where({ priority: priority })
     self
  end
  # A chainable method must always return self.
  def filter_todo_by_completion(completed)
    return self if completed.nil?
    completed_query = ActiveModel::Type::Boolean.new.cast(completed)
    @todos = @todos.where({completed: completed_query})
    self #reutrn current object to all methods as chains
  end



  def result
    @todos
  end
end