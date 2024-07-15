class Park < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :tags, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  def favorited?(user)
     favorites.where(user_id: user.id).exists?
  end

  validates :park_name, presence:true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode
end
