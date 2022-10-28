class EventsController < ApplicationController

    def show
      id = params[:id] # retrieve event ID from URI route
      @event = Event.find(id) # look up event by unique ID
      # will render app/views/events/show.<extension> by default
    end
  
    def index
      # TODO: record user during login
      # session[:username] = Username.new

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
      @event = Event.find(params[:id])
    end

    def join_event
      eid = params[:id]
      username = params[:username] #TODO: use session[:username]
      # upon clicking `Join`, add username to event's list of attendees
      @event = Event.find(eid)
      @event.add_person_to_event(username)  # returns true or false
      # TODO change status of button from `Join` to grayed `Joined`
      redirect_to action: 'show', id: eid
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
      @username = 'Mysaria' # TODO: session[:username]
      @host_events = Event.find_all_host_events(@username)
      if @host_events.nil? or @host_events.empty?
        @host_events = []
      end
      @join_events = Event.find_all_join_events(@username)
      if @join_events.nil? or @join_events.empty?
        @join_events = []
      end
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
  end
  