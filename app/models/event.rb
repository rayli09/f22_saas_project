class Event < ActiveRecord::Base
    enum status: [:open, :closed]
    has_many :comments, :dependent => :destroy #TODO this is placeholder for comments in T2
    serialize :people, Array
    # after_initialize do |event|
    #     event.people= [] if event.people == nil
    # end
    after_initialize :init_event

    def self.find_all_host_events(username)
        # events hosted by user
        # TODO better to use uid?
        Event.where(:host => username)
    end
    def self.find_all_join_events(username)
        # events joined by user
        # TODO better to use uid?
        Event.select { |event| event.people.include?("#{username}") }
    end
    
    #Find events by event name or host name or attendee name
    def self.find_event_by_name(name)
        #calling group here is necessary, otherwise duplicate entries will be returned
        Event.where("title LIKE ? OR host LIKE ? OR people LIKE ?", "%#{name}%", "%#{name}%", "%#{name}%")
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
        # @participants = Set.new
        @people = []
        @status = :open
        @people_limit = 10 #TODO refactor
    end
end
