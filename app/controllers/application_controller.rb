class ApplicationController < ActionController::Base
    
    include SessionsHelper
    
    private
    
    def require_user_logged_in
        unless logged_in?
            redirect_to login_url
            flash[:warning] = 'ログインしないと見れません'
        end
    end
    
    def counts(user)
        @count_articles = user.articles.count
        @count_followings = user.followings.count
        @count_followers = user.followers.count
        @count_favorites = user.favorites.count
    end
end
