class PostTag < ApplicationRecord
  belongs_to :park
  belongs_to :tag
  validates :park_id, presence: true
  validates :tag_id, presence: true
  
end
