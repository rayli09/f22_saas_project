class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    if cannot_create_user?(user_params)
      flash[:warning] = 'fields cannot be empty'
      redirect_to '/users/new?' and return
    end
    if User.find_by(username: user_params["username"])
      flash[:warning] = "username already exists"
      redirect_to '/users/new?' and return
    end
    @user = User.create(user_params)
    @user.update_attributes!({:rating => 5, :num_rating_got => 1})
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
  
  def rateUser
    # host rates all attendee && attendee rate one host
    event = Event.find(params[:id])
    u = current_user.username
    is_viewer_host = event.host == u
    if !is_viewer_host
      user =  User.find_by(username: event.host)
      update_user_rating(user, params[event.host])
    else
      event.people.each do |u|
        user =  User.find_by(username: u)
        update_user_rating(user, params[u])
      end
    end
    event.update_attribute(:rated_users, event.rated_users.push(u))
    flash[:notice] = is_viewer_host ?  "You've rated attendees!" : "You've rated your host!"
    redirect_to '/events/'+params[:id]
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :email, :show_email, :show_my_events)
  end
  private
  def update_user_rating(u, new_r)
    # update user rating, given new rating
    # if new_r.nil? return
    old_r = u.rating
    cnt = u.num_rating_got
    u.update_attribute(:rating, ((old_r * cnt + new_r.to_i)/(cnt+1)).floor)
    u.update_attribute(:num_rating_got, cnt + 1)
  end
  private
  def cannot_create_user?(user_params)
    user_params[:username].nil? or user_params[:username].blank? or user_params[:password].nil? or user_params[:password].blank?
  end
end
