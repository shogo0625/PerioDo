class RoutineTask < ApplicationRecord
	belongs_to :routine

  default_scope->{order(time: :asc)}

	validates :content, presence: :true, length: { maximum: 50 }
end
