class UsersController < ApplicationController  
  
  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      cookies.signed[:user_id] = @user.id
      redirect_to news_index_path
      flash[:notice] = "You have registred successfully."
    else
      flash[:error] = @user.errors.full_messages.first
      redirect_to new_user_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:email,:password,:name,:address)
  end

end