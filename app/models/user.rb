class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_one_attached :image
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [100, 100]).processed
  end
  
  GUEST_USER_EMAIL = "guest@example.com"
  GUEST_USER_BIRTH = "xxxx年xx月xx日"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL, birth:GUEST_USER_BIRTH) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
  
  validates :name, presence: true
  
  def self.looks(search)
      @records = User.where("name LIKE?","%#{search}%")
  end

end