class PostComment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  has_many :notifications, dependent: :destroy

  validates :comment, presence: true, length: { maximum: 100 }
end
