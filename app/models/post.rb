class Post < ApplicationRecord

  belongs_to :user

  has_many :comments
  has_many :likes, -> {order(created_at: :desc)},dependent: :destroy

  validates :content, presence: true, length: { maximum: 300 }
  validates :name, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader
  
  is_impressionable
  
  def liked_by(user)
    Like.find_by(user_id: user.id, post_id: id)
  end
  
  def self.search(name)
    Post.where(['name LIKE?', "%#{name}%"])
  end
end
