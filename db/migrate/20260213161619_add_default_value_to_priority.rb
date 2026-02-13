class AddDefaultValueToPriority < ActiveRecord::Migration[8.1]
  def change
    change_column_default :todos, :priority, 0
  end
end
