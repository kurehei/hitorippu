class User < ApplicationRecord
   before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :password , presence: true, length: { in: 6..15 } 
  has_secure_password
  validates :introduction, presence: true, length: { maximum: 150}
  
  has_many :likes
  has_many :posts
  has_many :comments
  has_many :relationships
  has_many :followings , through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  
  mount_uploader :image, ImageUploader
  
  include Gravtastic
 gravtastic
  
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  def unfollow(other_user)
    relationship=self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_posts
    Post.where(user_id: self.following_ids + [self.id])
  end
  
  def self.search(search)
    return User.all unless search
    User.where(['name LIKE?', "%#{search}%"])
  end
end
