class EventsController < ApplicationController

    def show
      id = params[:id] # retrieve event ID from URI route
      u = session[:username]
      @event = Event.find(id) # look up event by unique ID
      # will render app/views/events/show.<extension> by default
      @join_text = @event.people.include?(u) ? :Unjoin : :Join
      @join_btn_style = get_join_button_style(session[:username])
    end
  
    def index
      # TODO: record user during login
      session[:username] = 'testuser'

      #check for search query string
      if params[:q].nil? == false
        return @events = Event.find_event_by_name(params[:q])
      else
        return @events = Event.all
      end
    end
  
    def new
      # default: render 'new' template
    end

    def create
      @event = Event.create!(event_params)
      init_attributes = {:rating => '5.0/5.0', :joined => '0', :status => 0, :people => []}
      @event.update_attributes!(init_attributes)
      flash[:notice] = "Event '#{@event.title}' was successfully created."
      redirect_to events_path
    end

    def edit
      puts params
      @event = Event.find(params[:id])
    end

    def join
      u = session[:username]
      @event = Event.find(params[:id])
      is_unjoin = @event.people.include?(u)
      puts @join_text
      @event.update_attribute(:people, is_unjoin ? @event.people - [u] : @event.people.append(u))
      @join_btn_style = get_join_button_style(u)
      flash[:notice] = is_unjoin ? "You've unjoined it." : "You've joined it!"
      redirect_to event_path(@event)
    end

    def update
      @event = Event.find(params[:id])
      @event.update_attributes!(event_params)
      flash[:notice] = "Event '#{@event.title}' was successfully updated."
      redirect_to event_path(@event)
    end

    def destroy
      @event = Event.find(params[:id])
      @event.destroy
      flash[:notice] = "Event '#{@event.title}' was deleted."
      redirect_to events_path
    end
  
    def myEvents
      @username = session[:username] # TODO: session[:username]
      @host_events = Event.find_all_host_events(@username)
      @host_events = [] if @host_events.nil? or @host_events.empty?
      @join_events = Event.find_all_join_events(@username)
      @join_events = [] if @join_events.nil? or @join_events.empty?
    end

    def search
      #Default search template TODO: advanced search?
    end

    # TODO refactor this method to set required params
    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def event_params
      params.require(:event).permit(:title, :host, :rating, :joined, :people, :status, :event_time, :attendee_limit, :description, :q)
    end

    private
    def get_join_button_style(uname)
      return @event.people.include?(uname) ? 'btn btn-secondary col-2' :
      'btn btn-success col-2'
    end
  end
  