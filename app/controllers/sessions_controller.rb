class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: "signed in successfully"
    else
        flash.now[:alert] = "invalid email"
        render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "signed out successfully"
  end
end
