class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_many :posts, dependent: :destroy
  has_many :readings, foreign_key: "post_id", dependent: :destroy
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def read?
  end

  def unread?
  end

  def read_feed
    Post.from_users_read_posts(self)
  end

  def unread_feed
    Post.from_users_unread_posts(self)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
