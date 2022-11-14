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
    @user.update_attributes!({:rating => 5, :num_rating_got => 1})
    session[:user_id] = @user.id
    redirect_to '/welcome'
  end

  def rateUser
    # host rates all attendee &&
    # attendee rate one host
    event = Event.find(params[:id])
    u = current_user.username
    is_viewer_host = event.host == u
    if !is_viewer_host
      user =  User.find_by(username: event.host)
      # user.update_attribute(:rating, params[event.host])
      puts "_______"
      puts params
      puts "\n\n"
      puts "printing event .host"
      puts event.host
      update_user_rating(user, params[event.host])
      
    else
      event.people.each do |u|
        user =  User.find_by(username: u)
        # user.update_attribute(:rating, params[u])
        update_user_rating(user, params[u])

        # TODO 
      end
    end
    event.update_attribute(:rated_users, event.rated_users.push(u))
    flash[:notice] = is_viewer_host ?  "You've rated attendees!" : "You've rated your host!"
    redirect_to '/events/'+params[:id]
  end

  private
  def user_params
    params.require(:user).permit(:username,:password)
  end
  private
  def update_user_rating(u, new_r)
    # if new_r.nil? return
    old_r = u.rating
    cnt = u.num_rating_got
    # puts "new rting below!!!!!"
    # puts u.rating
    u.update_attribute(:rating, ((old_r * cnt + new_r.to_i)/(cnt+1)).floor)
    u.update_attribute(:num_rating_got, cnt + 1)
  end
end
