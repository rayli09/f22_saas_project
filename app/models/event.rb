class Event < ActiveRecord::Base
    enum status: [:open, :closed]
    has_many :comments, :dependent => :destroy
    has_and_belongs_to_many :users
    serialize :people, Array
    serialize :rated_users, Array
    after_initialize :init_event
    default_scope {order(promoted?: :DESC, event_time: :ASC)}

    def promotion_banner_style
        return 'table-success' if self.promoted?
        return ''
    end
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
            return Event.where("date_part('month',event_time) = ?", "#{month}")
        else
            return Event.where("date_part('year',event_time) = ?", "#{year}")
        end
    end

    # def self.find_event_by_rating(rating)
    #     if rating == "Rating"
    #         return nil
    #     else 
    #         # https://stackoverflow.com/questions/23633301/how-to-query-a-model-based-on-attribute-of-another-model-which-belongs-to-the-fi
    #         Event.joins(:users).where("users.rating = ?", rating)
    #     end
    # end

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
        @rated_users = []
        @status = :open
        @attendee_limit = 10 #TODO refactor
    end
end
