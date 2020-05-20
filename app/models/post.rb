class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  has_many :notifications, dependent: :destroy

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

  def commented_by?(user)
    post_comments.where(user_id: user.id).exists?
  end

  def create_notification_favorite!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, post_comment_id)
    temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, post_comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, post_comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'post_comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
