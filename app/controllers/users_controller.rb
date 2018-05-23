class UsersController < ApplicationController
  def myprofile
    @user = current_user
    if @user == nil
      redirect_to root_path, flash: {:alert => 'No user found'}
    end
    @activities = (@user.reviews + @user.likes + @user.favorites)
    @avg = @user.media
  end

  def profile
    begin
      @user = User.find(params[:id])
      @activities = (@user.reviews + @user.likes + @user.favorites)
      @avg = @user.media
    rescue ActiveRecord::RecordNotFound => e
      redirect_to root_path, flash: {:alert => 'No user found'}
    end
  end

  def favorites
    authenticate_user!
    @cocktails = current_user.favorites
  end

  def results
    @username = params[:usr]
    @users = User.where("username like ?", "%#{@username}%").order(:username)
    if @users.size == 0
      flash[:warning] = 'No users found!'
      redirect_to root_path
    end
  end
end