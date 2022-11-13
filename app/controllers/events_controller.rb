class EventsController < ApplicationController

    def show
      id = params[:id] # retrieve event ID from URI route
      # u = session[:username]
      u = current_user.username
      @event = Event.find(id) # look up event by unique ID
      # will render app/views/events/show.<extension> by default
      @join_text = @event.people.include?(u) ? :Unjoin : :Join
      @join_btn_style = get_join_button_style(u)
      @is_viewer_host = @event.host == u
      @username = u
    end
  
    def index
      # TODO: record user during login
      # session[:username] = 'testuser'

      #check for search query string
      q = params[:q].to_s.strip
      
      if not q.blank?
        event1 = Event.find_event_by_date(params[:select][:year], params[:select][:month])
        event2 = Event.find_event_by_rating(params[:rating_selected])
        event3 = Event.find_event_by_status(params[:status_selected])
        event4 = Event.find_event_by_name(q)
        @events = [ event1, event2, event3, event4 ].reject( &:nil? ).reduce( :& )
        @page_name = "Search Result for '#{q}'"
      else
        # if params[:select].blank? && params[:rating_selected].blank? #landing on home; render all
        #   @events = Event.all
        # elsif params[:select][:year].blank? && params[:select][:month].blank? && params[:rating_selected] == "Rating" #hitting search with no query
        #   @events = Event.all
        # else
        #   event1 = Event.find_event_by_date(params[:select][:year], params[:select][:month])
        #   event2 = Event.find_event_by_rating(params[:rating_selected])
        #   @events = [ event1, event2, Event.all ].reject( &:nil? ).reduce( :& )
        # end
        @events = Event.all
        @page_name = "Home"
      end
    end
  
    def new
      # default: render 'new' template
    end

    def create
      user = current_user.username
      check_result = is_event_params_valid(event_params)
      if check_result[:is_valid]
        @event = Event.create!(event_params)
        init_attributes = {:host => user, :rating => '5.0/5.0', :joined => '0', :status => 0, :people => [], :attendee_limit => 0}
        @event.update_attributes!(init_attributes)
        flash[:notice] = "Event '#{@event.title}' was successfully created."
        redirect_to events_path
      else
        flash[:warning] = "Field '#{check_result[:invalid_field]}' must be correctly filled in."
        # temporarily redirect to a new post event page
        redirect_to new_event_path
      end
    end

    def edit
      puts params
      @event = Event.find(params[:id])
    end

    def join
      u = current_user.username
      @event = Event.find(params[:id])
      is_unjoin = @event.people.include?(u)
      atts = @event.attributes
      atts[:people] = is_unjoin ? @event.people - [u] : @event.people.append(u)
      atts[:joined] = atts[:people].size
      @event.update_attributes!(atts)
      @join_btn_style = get_join_button_style(u)
      flash[:notice] = is_unjoin ? "You've unjoined it." : "You've joined it!"
      redirect_to event_path(@event)
    end

    def update
      @event = Event.find(params[:id])
      check_result = is_event_params_valid(event_params)
      if check_result[:is_valid]
        @event.update_attributes!(event_params)
        flash[:notice] = "Event '#{@event.title}' was successfully updated."
        redirect_to event_path(@event)
      else
        flash[:warning] = "Field '#{check_result[:invalid_field]}' must be correctly filled in."
        redirect_to edit_event_path(@event)
      end
    end

    def destroy
      @event = Event.find(params[:id])
      @event.destroy
      flash[:notice] = "Event '#{@event.title}' was deleted."
      redirect_to events_path
    end
  
    def myEvents
      @username = current_user.username # TODO: session[:username]
      @host_events = Event.find_all_host_events(@username)
      @host_events = [] if @host_events.nil? or @host_events.empty?
      @join_events = Event.find_all_join_events(@username)
      @join_events = [] if @join_events.nil? or @join_events.empty?
    end

    # TODO refactor this method to set required params
    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def event_params
      params.require(:event).permit(:title, :host, :rating, :joined, :people, :status, :event_time, :attendee_limit, :description, :q)
    end

    private
    def is_event_params_valid(params)
      result = {:is_valid => true, :invalid_field => 'None'}
      if params["title"].nil? or params["title"].blank?
        result[:is_valid] = false
        result[:invalid_field] = 'Title'
      elsif params["attendee_limit"].nil? or params["attendee_limit"].blank?
        result[:is_valid] = false
        result[:invalid_field] = 'Maximum Number of Attendees'
      end
      return result
    end

    private
    def get_join_button_style(uname)
      return 'btn btn-secondary col-2' if @event.people.include?(uname)
      return 'btn btn-success col-2 disabled' if @event.people.size >= @event.attendee_limit
      return 'btn btn-success col-2'
    end
  end
  