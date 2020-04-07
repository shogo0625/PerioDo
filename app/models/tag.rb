class Tag < ApplicationRecord
	has_and_belongs_to_many :post_tags

	validates :name, presence: :true, length: {maximum: 50}
end
