class Post < ApplicationRecord
	belongs_to :user
	has_many :post_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_and_belongs_to_many :tags

	attachment :image, destroy: false
	validates :content, presence: true, length: {maximum: 160}
end
