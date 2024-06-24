class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  has_one_attached :image
  belongs_to :user
  belongs_to :genre
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    user.present?
    favorites.exists?(user_id: user.id)
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_fill: [width, height]).processed
  end

  def self.looks(search)
      @records = Post.where("title LIKE?","%#{search}%")
  end
  
  def self.liked_posts(user) 
    includes(:post_favorites) 
      .where(post_favorites: { user_id: user.id }) 
      .order(created_at: :desc)
  end
end
