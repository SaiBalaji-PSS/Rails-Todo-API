class Todo < ApplicationRecord
  enum :priority, { low: 0, medium: 1, high: 2 } # enum is a method from active records
  validates :title, presence: { message: "Title can't be blank" }
  validates :due_date, presence: { message: "Due date can't be blank" }
end
