class Event < ActiveRecord::Base
    enum status: [:open, :closed]
    has_many :comments, :dependent => :destroy
    serialize :people, Array
    after_initialize :init_event

    def self.find_all_host_events(username)
        Event.where(:host => username)
    end
    def self.find_all_join_events(username)
        Event.select { |event| event.people.include?("#{username}") }
    end
    def self.find_event_by_name(name)
        #calling group here is necessary, otherwise duplicate entries will be returned
        Event.where("title LIKE ? OR host LIKE ? OR people LIKE ?", "%#{name}%", "%#{name}%", "%#{name}%")
    end
    
    private 
    def init_event
        @people = []
        @status = :open
        @attendee_limit = 10 #TODO refactor
    end
end
