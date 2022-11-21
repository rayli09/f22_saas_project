class Reaction < ActiveRecord::Base
    belongs_to :comment, :class_name => "Comment", :foreign_key => "comment_id"
    belongs_to :user, :class_name => "User", :foreign_key => "user_id"

    def self.count_reacts(comment_id, action_id)
        Reaction.where({:comment_id => comment_id, :action => action_id}).count
    end
end