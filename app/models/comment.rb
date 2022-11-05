class Comment < ActiveRecord::Base
    belongs_to :event, :class_name => "Event", :foreign_key => "event_id"#TODO this is placeholder for comments in T2
    belongs_to :user, :class_name => "User", :foreign_key => "user_id"
end
