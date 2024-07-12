class Park < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :tag, dependent: :destroy
  has_many :favorite, dependent: :destroy
  has_many :comment, dependent: :destroy

  validates :park_name, presence:true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode
end
