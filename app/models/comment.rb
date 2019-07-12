class Comment < ApplicationRecord
    belongs_to :article
    belongs_to :user, optional: true
    
    validates :name, length: { maximum: 30 }
    validates :content, presence: true, length: { maximum: 255 }
    
    
end
