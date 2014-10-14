class Reading < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :post, dependent: :destroy
  validates :user_id, presence: true
  validates :post_id, presence: true
end
