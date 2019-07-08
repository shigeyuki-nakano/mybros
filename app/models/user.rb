class User < ApplicationRecord
    validates :username, presence: true, length: { maximum: 30 },
              format: { with: /\A[a-zA-Z0-9]+\z/ },  #  半角英数字のみ
              uniqueness: { case_sensitive: false }
    validates :name, presence: true, length: { maximum: 30 }
    validates :email, presence: true, length: { maximum: 255 }, 
              format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
              uniqueness: { case_sensitive: false }
    
    has_secure_password
end
