class Reaction < ActiveRecord::Base
    belongs_to :comment, :class_name => "Comment", :foreign_key => "comment_id"
    belongs_to :user, :class_name => "User", :foreign_key => "user_id"

    def self.count_reacts(comment_id)
        Reaction.where({:comment_id => comment_id}).count
    end
    def self.find_people(comment_id)
        User.where(:id => Reaction.where({:comment_id => comment_id}).pluck(:user_id)).limit(2).pluck(:username)
    end
    def self.is_reacted(comment_id, user_id)
        Reaction.where({:comment_id => comment_id, :user_id => user_id}).present?
    end
    def self.is_thumbuped(comment_id, user_id)
        Reaction.where({:comment_id => comment_id, :user_id => user_id, :action => 0}).present?
    end
    def self.is_liked(comment_id, user_id)
        Reaction.where({:comment_id => comment_id, :user_id => user_id, :action => 1}).present?
    end
    def self.is_laughed(comment_id, user_id)
        Reaction.where({:comment_id => comment_id, :user_id => user_id, :action => 2}).present?
    end
end