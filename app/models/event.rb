class Event < ActiveRecord::Base
    #self.primary_keys = :event_id
    serialize :people, Array
    after_initialize do |event|
        event.people= [] if event.people == nil
    end
    def self.find_all_host_events(username)
        Event.where(:host => username)
    end
    def self.find_all_join_events(username)
        Event.where("people like ?", "%#{username}%")
    end
end
