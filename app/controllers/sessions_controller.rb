class SessionsController < ApplicationController
  def new
  end

  def create
    username = params[:session][:username].downcase
    password = params[:session][:password]
    if login(username, password)
      flash[:success] = 'ログインしました'
      redirect_to @user
    else
      flash.now[:danger] = 'ログインできませんでした'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end
  
  private
  
  def login(username, password)
    @user = User.find_by(username: username)
    if @user && @user.authenticate(password)
      # ログイン保持
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
end
