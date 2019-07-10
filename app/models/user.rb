class User < ApplicationRecord

    validates :username, presence: true, length: { maximum: 30 },
              format: { with: /\A[a-zA-Z0-9]+\z/ },  #  半角英数字のみ
              uniqueness: { case_sensitive: false }
              
    validates :name, presence: true, length: { maximum: 30 }
    
    validates :email, presence: true, length: { maximum: 255 }, 
              format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
              uniqueness: { case_sensitive: false }
       
    # プロフィール用       
    validates :introduce, length: { maximum: 255 }
    validates :address, length: { maximum: 50 }
    
    has_secure_password
    
    has_many :articles
    
    has_many :relationships
    has_many :followings, through: :relationships, source: :follow
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
    has_many :followers, through: :reverses_of_relationship, source: :user
    
    has_many :favorites, dependent: :destroy
    has_many :favorite_articles, through: :favorites, source: :article
    
    def follow(other_user)
        unless self == other_user
           self.relationships.find_or_create_by(follow_id: other_user.id) 
        end
    end
    
    def unfollow(other_user)
        relationship = self.relationships.find_by(follow_id: other_user.id)
        relationship.destroy if relationship
    end
    
    def following?(other_user)
       self.followings.include?(other_user) 
    end
    
    def like(article)
       self.favorites.find_or_create_by(article_id: article.id) 
    end
    
    def unlike(article)
        favorite = self.favorites.find_by(article_id: article.id)
        favorite.destroy if favorite
    end
    
    def liked?(article)
        self.favorite_articles.include?(article)
    end
end
