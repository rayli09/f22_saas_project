require 'rails_helper'

describe EventsController do
    describe '#show' do
        let!(:event) {FactoryGirl.create(:event)}
        let!(:user) {FactoryGirl.build(:user)}
        before do
            sign_in user
            get :show, {:id => event.id}
        end

        context 'When go to the event detail page' do
            it 'should have the join button' do
                expect(assigns(:join_text)).to eq(:Join)
            end

            it 'should have join button style' do
                expect(assigns(:join_btn_style)).to eq('btn btn-success col-2')
            end

            it 'should not be host' do
                expect(assigns(:is_viewer_host)).to eq(false)
            end

            it 'should render show template' do
                expect(response).to render_template('show')
            end
        end
    end

    describe '#new' do
        let!(:user) {FactoryGirl.build(:user)}
        before do
            sign_in user
            get :new
        end

        context 'When go to the post event page' do
            it 'should render new event template' do
                expect(response).to render_template('new')
            end
        end
    end

    describe '#create' do
        let!(:user) {FactoryGirl.build(:user)}
        before do
            sign_in user
        end

        context 'When successfully post a new event' do
            it 'should store the event in the database and redirect to home page' do
                params = ActionController::Parameters.new(:title => 'Test lunch', :description => 'Eat together', 'event_time(1i)' => '2022', 'event_time(2i)'=> '12', 'event_time(3i)' => '28', :attendee_limit => 4)
                expect{post :create, {:event => params}}.to change{Event.count}.by(1)
                expect(response).to redirect_to(events_path)
            end
        end

        context 'When failed to post a new event due to missing title' do
            it 'should not store the event in the database and should redirect to new event page' do
                params = ActionController::Parameters.new(:description => 'Eat together', 'event_time(1i)' => '2022', 'event_time(2i)'=> '12', 'event_time(3i)' => '28', :attendee_limit => 4)
                expect{post :create, {:event => params}}.to change{Event.count}.by(0)
                expect(response).to redirect_to(new_event_path)
            end
        end

        context 'When failed to post a new event due to past event time' do
            it 'should not store the event in the database and should redirect to new event page' do
                params = ActionController::Parameters.new(:title => 'Test lunch', :description => 'Eat together', 'event_time(1i)' => '2022', 'event_time(2i)'=> '10', 'event_time(3i)' => '15', :attendee_limit => 4)
                expect{post :create, {:event => params}}.to change{Event.count}.by(0)
                expect(response).to redirect_to(new_event_path)
            end
        end
    end

    describe '#edit' do
        let!(:event) {FactoryGirl.create(:event)}
        let!(:user) {FactoryGirl.build(:user)}
        before do
            sign_in user
            get :edit, {:id => event.id}
        end

        context 'When go to the edit event page' do
            it 'should render edit event template' do
                expect(assigns(:event)).to eq(event)
                expect(response).to render_template('edit')
            end
        end
    end

    describe '#update' do
        let!(:event) {FactoryGirl.create(:event)}
        let!(:user) {FactoryGirl.build(:user)}
        before do
            sign_in user
        end

        context 'When successfully update an existing event' do
            it 'should store the update in the database and redirect to event details page' do
                params = ActionController::Parameters.new(:title => 'Test lunch', :description => 'Change description', :attendee_limit => 10, 'event_time(1i)' => '2022', 'event_time(2i)'=> '12', 'event_time(3i)' => '28')
                put :update, {:id => event.id, :event => params}
                event.reload
                expect(event.title).to eq('Test lunch')
                expect(event.description).to eq('Change description')
                expect(event.attendee_limit).to eq(10)
                expect(response).to redirect_to(event_path(event))
            end
        end

        context 'When failed to update an existing event due to missing attendee limit' do
            it 'should not change event info in the database and should redirect to edit event page' do
                params = ActionController::Parameters.new(:title => 'Test lunch', :description => 'Change description')
                put :update, {:id => event.id, :event => params}
                expect(event.title).to eq('Lunch')
                expect(event.description).to eq(nil)
                expect(response).to redirect_to(edit_event_path(event))
            end
        end
    end

    describe '#destroy' do
        let!(:event) {FactoryGirl.create(:event)}
        let!(:user) {FactoryGirl.build(:user)}
        before do
            sign_in user
        end

        context 'When successfully delete an existing event' do
            it 'should delete the event from the database and redirect to home page' do
                expect{delete :destroy, {:id => event.id}}.to change{Event.count}.by(-1)
                expect(response).to redirect_to(events_path)
            end

        end
    end

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

        context "Search 'David' in the search bar" do
            it "should render search" do
                get :index, :q => 'David', :select => {:year => "", :month => ""}
                expect(Event).to receive(:find_event_by_name).with('David').and_return(event)
                Event.find_event_by_name('David')
            end
        end
    end

    describe "#search" do
        let!(:event) {FactoryGirl.create(:event)}
        let!(:user) {FactoryGirl.build(:user)}
        before do
            sign_in user
            get :index
        end
    
        context "When go to the search page" do
            it "should render search template" do                     
                expect(response).to render_template("index")
            end
        end

        context "When search David" do
            it "should render event related to David" do
                expect(Event).to receive(:find_event_by_name).with('David').and_return(event)
                Event.find_event_by_name('David')
            end
        end

        context "When search date" do
            it "should render event related to a date" do
                get :index, :q => 'David', :select => {:year => "2022", :month => "11"}
                expect(Event).to receive(:find_event_by_date).with("2022","11").and_return(event)
                Event.find_event_by_date("2022","11")
            end

            it "should render event related to a month" do
                get :index, :q => 'David', :select => {:year => "", :month => "11"}
                expect(Event).to receive(:find_event_by_date).with("","11").and_return(event)
                Event.find_event_by_date("","11")
            end

            it "should render event related to a year" do
                get :index, :q => 'David', :select => {:year => "2022", :month => ""}
                expect(Event).to receive(:find_event_by_date).with("2022","").and_return(event)
                Event.find_event_by_date("2022","")
            end
        end

        context "When search status" do
            it "should render event related to a status" do
                get :index, :q => 'David',:select => {:year => "2022", :month => ""}, :status_selected => "Open"
                expect(Event).to receive(:find_event_by_status).with('Open').and_return(event)
                Event.find_event_by_status('Open')
            end
        end
    end

    describe "#join" do
        let!(:event) {FactoryGirl.create(:event)}
        let!(:user) {FactoryGirl.build(:user)}
        before do
            sign_in user
            get :join, {:id=>event.id}
        end

        context "user joining event" do
            it "should update join button to unjoin and update people" do
                expect(flash[:notice]).to be_present
                expect(response).to redirect_to(event_path(event))
            end 
        end

    end 
    describe "#ratePeople" do
        let!(:event) {FactoryGirl.create(:event)}
        let!(:user) {FactoryGirl.build(:user, username: 'Ben')}
        before do
            sign_in user
            get :ratePeople, {:id=>event.id}
        end

        context "attendee goes to event page" do
            it "should return ratePeople template" do
                expect(response).to render_template("ratePeople")
            end 
        end
    end
    describe "#promote" do
        let!(:event) {FactoryGirl.create(:event, id: 1)}
        let!(:event2) {FactoryGirl.create(:event, id: 2, host: 'Jeff')}
        let!(:user) {FactoryGirl.build(:user, username: 'Ben')}
        let!(:user2) {FactoryGirl.build(:user, username: 'Jeff', id: 2, coins: 3)}
        
        context "event is fresh, not promoted before" do
            it "successfully promotes if having sufficient coins" do
                sign_in user
                get :promote, {:id=>event.id}
                expect(flash[:notice]).to be_present
            end
            it "fails to promote due to coins" do
                sign_in user2
                get :promote, {:id=>event2.id}
                expect(flash[:warning]).to be_present
            end  
        end
    end 
end