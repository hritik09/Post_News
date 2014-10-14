class Reading < ActiveRecord::Base
  attr_accessible :user_id, :post_id
  belongs_to :user, dependent: :destroy
  belongs_to :post, dependent: :destroy
  validates :user_id, presence: true
  validates :post_id, presence: true
end
