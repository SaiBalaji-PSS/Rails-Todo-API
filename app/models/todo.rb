class Todo < ApplicationRecord
  belongs_to :user, foreign_key: :user_id, primary_key: :user_id
  enum :priority, { low: 0, medium: 1, high: 2 } # enum is a method from active records
  validates :title, presence: { message: "Title can't be blank" }
  validates :due_date, presence: { message: "Due date can't be blank" }
end
