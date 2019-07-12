class Article < ApplicationRecord
  mount_uploader :title_image, TitleImageUploader
  
  mount_uploader :article_image, ArticleImageUploader
  
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :article, presence: true, length: { maximum: 1000 }
  
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  has_many :comments, dependent: :destroy
end
