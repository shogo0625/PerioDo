class PostTag < ApplicationRecord
	belongs_to :post
	belongs_to :tag

	self.primary_key = "post_id"

	validates :post_id, presence: :true
	validates :tag_id, presence: :true
end
