class PremadeTask < ApplicationRecord
	belongs_to :user

  default_scope->{order(time: :asc)}

	validates :content, presence: :true, length: { maximum: 50 }
end
