class Park < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  def favorited?(user)
     favorites.where(user_id: user.id).exists?
  end
  
  def save_tag(sent_tags)
      current_tags = self.tags.pluck(:name) unless self.tags.nil?
      old_tags = current_tags - sent_tags
      new_tags = sent_tags - current_tags
    
      old_tags.each do |old|
        self.tags.delete　Tag.find_by(name: old)
      end
    
      new_tags.each do |new|
        new_post_tag = Tag.find_or_create_by(name: new)
        self.tags << new_post_tag
     end
  end

  validates :park_name, presence:true
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode
end
