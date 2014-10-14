class Post < ActiveRecord::Base
  attr_accessible :content, :title
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  # Returns microposts from the users being followed by the given user.
  def self.from_users_read_posts(user)
    read_post_ids = "SELECT post_id FROM readings
                         WHERE user_id = :user_id"
    where("posts.id IN (#{read_post_ids})",
          user_id: user.id)
  end

  def self.from_users_unread_posts(user)
    read_post_ids = "SELECT post_id FROM readings
                         WHERE user_id = :user_id"
    where("posts.id NOT IN (#{read_post_ids})",
          user_id: user.id)
  end

  def self.all_rows
    post_ids = "SELECT id FROM posts"
    where("posts.id IN (#{post_ids})")
  end
end
