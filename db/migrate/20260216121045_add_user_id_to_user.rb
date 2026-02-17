class AddUserIdToUser < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :user_id, :string
  end
end
