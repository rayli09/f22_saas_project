class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :welcome, :logout, :omniauth]
  def new
  end

  def create
    if cannot_login? params
      flash[:warning] = 'fields cannot be null'
      redirect_to '/login' and return
    end
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

 def omniauth
   @user = User.from_omniauth(auth)
   @user.save
   session[:user_id] = @user.id
   redirect_to '/welcome'
 end

 private
 def auth
   request.env['omniauth.auth']
 end
 private 
 def cannot_login?(params)
  params[:username].nil? or params[:password].blank? or params[:password].nil? or params[:password].blank?
 end
end
