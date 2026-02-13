class AddDefaultValueToCompleted < ActiveRecord::Migration[8.1]
  def change
    change_column_default :todos, :completed, false
  end
end
