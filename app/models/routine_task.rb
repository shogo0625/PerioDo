class RoutineTask < ApplicationRecord
  belongs_to :routine

  validates :content, presence: :true, length: { maximum: 50 }
end
