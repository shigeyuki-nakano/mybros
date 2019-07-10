class Article < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :article, presence: true, length: { maximum: 500 }
end
