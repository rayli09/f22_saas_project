require 'rails_helper'

describe EventsController do
    describe "#index" do
        let!(:event) {FactoryGirl.create(:event)}
        let!(:user) {FactoryGirl.build(:user)}
        before do
            sign_in user
            get :index
        end
        
        context "When go to the index page" do
            it "should render index template" do                     
                expect(response).to render_template("index")
            end
        end
    end

    describe "#search" do
        let!(:event) {FactoryGirl.create(:event)}
        let!(:user) {FactoryGirl.build(:user)}
        before do
            sign_in user
            get :search
        end
    
        context "When go to the search page" do
            it "should render search template" do                     
                expect(response).to render_template("search")
            end
        end

        context "When search David" do
            it "should render event related to David" do
                expect(Event).to receive(:find_event_by_name).with('David').and_return(event)
                Event.find_event_by_name('David')
            end
        end
    end
end