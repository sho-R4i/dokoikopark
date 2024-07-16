class Comment < ApplicationRecord
  belongs_to :park
  belongs_to :user
  
  validates :content, presence:true
end
