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
        Event.where("title ILIKE ? OR host ILIKE ? OR people ILIKE ?", "%#{name}%", "%#{name}%", "%#{name}%")
    end

    def self.find_event_by_date(year, month)
        if !year.empty? && !month.empty?
            return Event.where("date_part('year',event_time) = ?", year).where("date_part('month',event_time) = ?", month)
        elsif year.empty? && month.empty?
            return nil
        elsif year.empty?
            return find_event_by_month(month)   
        else
            return find_event_by_year(year)
        end
    end

    def self.find_event_by_year(year)
        Event.where("date_part('year',event_time) = ?", "#{year}")
    end

    def self.find_event_by_month(month)
        Event.where("date_part('month',event_time) = ?", "#{month}")
    end

    def self.find_event_by_rating(rating)
        if rating == "Rating"
            return nil
        else 
            Event.where("rating = ?", "#{rating}")
        end
    end

    def self.find_event_by_status(status)
        if status == "Status"
            return nil
        elsif status == "Open"
            Event.where("status = 0")
        else
            Event.where("status = 1")
        end
    end

    # INTERNAL
    private 
    def init_event
        @people = []
        @status = :open
        @attendee_limit = 10 #TODO refactor
    end
end
