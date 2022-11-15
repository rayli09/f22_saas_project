class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    if User.find_by(username: user_params["username"])
      flash[:warning] = "username already exists"
      redirect_to '/users/new?' and return
    end
    @user = User.create(user_params)
    @user.update_attributes!({:rating => 3})
    session[:user_id] = @user.id
    redirect_to '/welcome'
  end

  def show
    @user = User.find(params[:id])
    @is_viewer_user = @user.username == current_user.username
    @host_events = Event.find_all_host_events(@user.username)
    @host_events = [] if @host_events.nil? or @host_events.empty?
    @join_events = Event.find_all_join_events(@user.username)
    @join_events = [] if @join_events.nil? or @join_events.empty?
  end

  def myProfile
    @username = current_user.username
    redirect_to user_path(current_user)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if (!user_params["email"].blank?) and (user_params["email"] !~ URI::MailTo::EMAIL_REGEXP)
      flash[:warning] = "Email must be correctly filled in."
      redirect_to edit_user_path(@user)
    else
      @user.update_attributes!(user_params)
      flash[:notice] = "User '#{@user.username}' was successfully updated."
      redirect_to user_path(@user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
end
