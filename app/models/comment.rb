class Comment < ApplicationRecord
  belongs_to :park
  belongs_to :user
  
  validates :comment, presence:true
end
