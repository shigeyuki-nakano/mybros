class UsersController < ApplicationController
    before_action :require_user_logged_in, except: [:new, :create]
    
    def index
        @users = User.order(id: :desc).page(params[:page]).per(10)
    end
    
    def show
        @user = User.find(params[:id])
        @articles = @user.articles.order(id: :desc).page(params[:page])
        counts(@user)
    end
    
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        
        if @user.save
            flash[:success] = 'ユーザーを登録しました！'
            redirect_to login_path
        else
            flash.now[:danger] = 'ユーザーの登録に失敗しました...。'
            render :new
        end
    end
    
    def edit
        @user = User.find(params[:id])
    end
    
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:success] = 'プロフィールを更新しました'
            redirect_to user_path(@user)
        else
            flash[:destroy] = 'プロフィールを更新できませんでした'
            redirect_back(fallback_location: root_path)
        end
    end
    
    def destroy
    end
    
    
    def followings
        @user = User.find(params[:id])
        @followings = @user.followings.page(params[:page])
        counts(@user)
    end
    
    def followers
        @user = User.find(params[:id])
        @followers = @user.followers.page(params[:page])
        counts(@user)
    end    
    
    def likes
        @user = User.find(params[:id])
        @favorite_articles = @user.favorite_articles.page(params[:page])
        counts(@user)
    end
    
    private
    
    # ストロングパラメータ
    def user_params
        params.require(:user).permit(:username, :name, :email, :password, :password_confirmation, :introduce, :age, :sex, :address)
    end
end
