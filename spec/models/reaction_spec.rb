require 'rails_helper'

RSpec.describe Reaction, type: :model do
    describe "#count_react" do
        it "should return the number of reactions to a comment" do
            reaction1 = Reaction.create! :comment_id => 1, :user_id => 1, :action => 0
            expect(Reaction.count_reacts(1)).to equal(1)
        end
    end

    describe "#find_people" do
        it "should return the username of the people who reacted to the comment" do
            user = User.create! :id => 1, :username => 'Test User', :password => '1'
            reaction1 = Reaction.create! :comment_id => 1, :user_id => 1, :action => 0
            expect(Reaction.find_people(1)).to include('Test User')
        end
    end

    describe "#is_reacted" do
        it "should return whether the user reacted to the comment" do
            user = User.create! :id => 1, :username => 'Test User', :password => '1'
            reaction1 = Reaction.create! :comment_id => 1, :user_id => 1, :action => 0
            expect(Reaction.is_reacted(1, 1)).to equal(true)
        end
    end

    describe "#is_thumbuped" do
        it "should return whether the user thumbed up to the comment" do
            user = User.create! :id => 1, :username => 'Test User', :password => '1'
            reaction1 = Reaction.create! :comment_id => 1, :user_id => 1, :action => 0
            expect(Reaction.is_thumbuped(1, 1)).to equal(true)
        end
    end

    describe "#is_liked" do
        it "should return whether the user liked the comment" do
            user = User.create! :id => 1, :username => 'Test User', :password => '1'
            reaction1 = Reaction.create! :comment_id => 1, :user_id => 1, :action => 1
            expect(Reaction.is_liked(1, 1)).to equal(true)
        end
    end

    describe "#is_laughed" do
        it "should return whether the user laughed at the comment" do
            user = User.create! :id => 1, :username => 'Test User', :password => '1'
            reaction1 = Reaction.create! :comment_id => 1, :user_id => 1, :action => 2
            expect(Reaction.is_laughed(1, 1)).to equal(true)
        end
    end
end