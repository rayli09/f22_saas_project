class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :welcome, :logout]
  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
       session[:user_id] = @user.id
       redirect_to '/welcome'
    else
       flash[:warning] = @user.nil? ? 'User does not exist' : 'Invalid credentials!'
       redirect_to '/login'
    end
 end
 
 def logout
  session[:user_id] = nil
  flash[:notice] = 'You successfully logged out.'
  redirect_to '/welcome'
 end

 def page_requires_login
 end
end
