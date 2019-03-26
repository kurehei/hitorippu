class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :content, presence: true, length: { maximum: 300 }
  validates :name, presence: true
  validates :image, presence: true
  mount_uploader :image, ImageUploader
  
  def Post.search(search)
    return Post.all unless search
    Post.where(['name LIKE?', "%#{search}%"])
  end
end
