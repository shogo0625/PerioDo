class Task < ApplicationRecord
	belongs_to :user

	enum status: {ToDo: 0,Doing: 1,Done: 2}

	validates :content, presence: true, length: {maximum: 50}
end
