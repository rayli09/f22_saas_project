class Comment < ActiveRecord::Base
    belongs_to :event #TODO this is placeholder for comments in T2
    belongs_to :user
end
