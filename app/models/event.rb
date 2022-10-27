class Event < ActiveRecord::Base
    has_many :comment, :dependent => :destroy  #TODO this is placeholder for comments in T2
    serialize :people, Array
    after_initialize do |event|
        event.people= [] if event.people == nil
    end
    after_initialize :init_event  # better way?

    def self.find_all_host_events(username)
        # events hosted by user
        # TODO better to use uid?
        Event.where(:host => username)
    end
    def self.find_all_join_events(username)
        # events joined by user
        # TODO better to use uid?
        Event.where("people like ?", "%#{username}%")
    end
    def add_person_to_event(uid)
        # add a user to the event
        @participants = @participants.add(uid)
    end
    
    def get_user_status(uid)
        # HELPER method: given uid, return the status to render on HTML
        # e.g. JOINED, JOIN, COMPLETE
        # use this to render the button status
        # ------------------------------------------------------------
        # JOINED: user already joined this event
        # JOIN: user can join event
        # CLOSED: event's complete, can't modify
        # FULL: can't join right now because it's full
        # ------------------------------------------------------------
        return :CLOSED if @status == :closed
        return :FULL if @participants.size >= @people_limit
        return :JOIN if !@participants.include?(uid)
        return :JOINED
    end
    # INTERNAL
    private 
    def init_event
        # init
        # ----------------------------------------------------
        # participants: Set of uids, avoid dup
        # status: :open || :full || :closed
        # people_limit: number of people allowed in this event
        # ----------------------------------------------------
        @participants = Set.new
        @status = :open
        @people_limit = 10 #TODO refactor
    end
end
