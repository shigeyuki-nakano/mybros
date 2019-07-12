class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :article
  counter_culture :article
  validates :user_id, presence: true
  validates :article_id, presence: true
end
