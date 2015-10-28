class SessionsController < ApplicationController
  def create
    if user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      flash[:success] = 'Logged In.'
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:danger] = 'Logged Out.'
    redirect_to root_path
  end

  def failure
    flash[:danger] = 'Invalid Credentials. Please try again.'
    redirect_to root_path
  end
end
