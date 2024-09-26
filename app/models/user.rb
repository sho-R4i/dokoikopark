class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :name, presence: true

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end

  has_many :parks, dependent: :destroy
  
  has_many :favorites, dependent: :destroy
  has_many :favorite_parks, through: :favorites, source: :park
  has_many :comments, dependent: :destroy
  has_many :comment_parks, through: :comments, source: :park

  has_one_attached :profile_image

  def profile_image?
     profile_image.present?
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
  profile_image.variant(resize_to_limit: [width, height]).processed
  end

end