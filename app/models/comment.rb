class Comment < ApplicationRecord
  belongs_to :parkt
  belongs_to :user
end
