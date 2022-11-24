class Reaction < ActiveRecord::Base
    belongs_to :comment, :class_name => "Comment", :foreign_key => "comment_id"
    belongs_to :user, :class_name => "User", :foreign_key => "user_id"

    def self.count_reacts(comment_id)
        Reaction.where({:comment_id => comment_id}).count
    end
    def self.find_people(comment_id)
        User.where(:id => Reaction.where({:comment_id => comment_id}).pluck(:user_id)).limit(2).pluck(:username)
    end
end