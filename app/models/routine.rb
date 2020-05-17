class Routine < ApplicationRecord
  belongs_to :user
  has_many :routine_tasks, dependent: :destroy

  enum status: { Routine: 0, Record: 1}

  default_scope->{order(created_at: :desc)}

  validates :title, presence: true, length: { maximum: 50 }
  validates :comment, presence: true, length: { maximum: 1000 }
end
