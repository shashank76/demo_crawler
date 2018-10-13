class SessionsController < ApplicationController
  def new
    redirect_to news_index_path if current_user.present?
  end

  def create
    if @user = User.find_by(email: params[:session][:email])
      if @user && @user.valid_password?(params[:session][:password])
					if params[:session][:remember_me].eql?("1")
              cookies.signed[:user_id] = { value: @user.id}
            else
              cookies.signed[:user_id] = @user.id
            end
          flash[:notice] = "You have successfully logged In."
          redirect_to news_index_path
      else
     		redirect_to new_session_path
        flash[:error] = "Invalid Email or Password"
      end
    else
      redirect_to new_session_path
      flash[:error] = "Invalid Email, Please try again."
    end
	end

	def destroy
    cookies.delete :user_id
    # flash[:success] = "You have successfully logged out."
    redirect_to new_session_path
	end
end
