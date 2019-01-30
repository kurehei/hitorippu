class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :content, presence: true, length: { maximum: 300 }
  validates :name, presence: true
  mount_uploader :image, ImageUploader
end
