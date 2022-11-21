class Reaction < ActiveRecord::Base
    belongs_to :comment, :class_name => "Comment", :foreign_key => "comment_id"
    belongs_to :user, :class_name => "User", :foreign_key => "user_id"

    def self.count_likes(comment_id)
        Reaction.where({:comment_id => comment_id, :action => 0}).count
    end
    def self.count_ups(comment_id)
        Reaction.where({:comment_id => comment_id, :action => 1}).count
    end
    def self.count_downs(comment_id)
        Reaction.where({:comment_id => comment_id, :action => 2}).count
    end
end