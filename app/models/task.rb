class Task < ApplicationRecord
  belongs_to :user

  enum status: { ToDo: 0, Doing: 1, Done: 2 }

  default_scope->{order(time_limit: :asc)}

  validates :content, presence: true, length: { maximum: 50 }
end
