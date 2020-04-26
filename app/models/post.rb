class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  attachment :image, destroy: false
  validates :content, presence: true, length: { maximum: 160 }

  after_create do
    post = Post.find_by(id: id)
    tags = content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |t|
      tag = Tag.find_or_create_by(name: t.delete('#')) # ハッシュタグの'#'を外して保存
      post.tags << tag
    end
  end

  before_update do
    post = Post.find_by(id: id)
    post.tags.clear
    tags = content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.map do |t|
      tag = Tag.find_or_create_by(name: t.delete('#'))
      post.tags << tag
    end
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
