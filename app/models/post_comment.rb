class PostComment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :comment, presence: true, length: { maximum: 100 }
end
