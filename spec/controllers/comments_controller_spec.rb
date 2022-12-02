require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
describe CommentsController do
    describe "#create" do 
        let!(:user) {FactoryGirl.create(:user)}
        let!(:event) {FactoryGirl.create(:event)}
        before do
            sign_in user
        end

        context 'When successfully post a new comment' do
            it 'should store the comment in the database and redirect to the event detail page' do
                params = ActionController::Parameters.new(:content => 'Test Comment', :event_id => event.id, :user_id => user.id)
                post :create, {event_id: event.id, comment: params, format: :json}
                expect(event.comments.count).to equal(1)
                expect(user.comments.count).to equal(1)
                expect(response).to redirect_to(event_path(event))
            end
        end

        context 'When failed to post an empty comment' do
            it 'should not store the comment in the database and should redirect to the event detail' do
                params = ActionController::Parameters.new(:content => '', :event_id => event.id, :user_id => user.id)
                post :create, {event_id: event.id, comment: params, format: :json}
                expect(event.comments.count).to equal(0)
                expect(user.comments.count).to equal(0)
                expect(response).to redirect_to(event_path(event))
            end
        end
    end

    describe '#edit' do
        let!(:event) {FactoryGirl.create(:event)}
        let!(:user) {FactoryGirl.build(:user)}
        let!(:comment) {FactoryGirl.create(:comment)}
        before do
            sign_in user
            get :edit, {:id => comment.id, :event_id => event.id}
        end

        context 'When go to the edit comment page' do
            it 'should render edit comment template' do
                expect(assigns(:comment)).to eq(comment)
                expect(response).to render_template('edit')
            end
        end
    end 

    describe '#update' do
        let!(:event) {FactoryGirl.create(:event)}
        let!(:user) {FactoryGirl.build(:user)}
        let!(:comment) {FactoryGirl.create(:comment)}
        before do
            sign_in user
        end

        context 'When successfully update an existing comment' do
            it 'should store the update in the database and redirect to the event detail page' do
                params = ActionController::Parameters.new(:id => comment.id, :content => 'Test Comment:)', :user_id => comment.user_id, :event_id => comment.event_id)
                put :update, {id: comment.id, event_id: event.id, comment: params}
                comment.reload
                expect(comment.content).to eq('Test Comment:)')
            end
        end

        context 'When failed to update an existing comment to empty string' do
            it 'should not change comment in the database and should redirect to edit comment page' do
                params = ActionController::Parameters.new(:id => comment.id, :content => '', :user_id => comment.user_id, :event_id => comment.event_id)
                put :update, {id: comment.id, event_id: event.id, comment: params}
                expect(response).to redirect_to(edit_event_comment_path(event, comment))
            end
        end
    end

    describe '#destroy' do
        let!(:event) {FactoryGirl.create(:event)}
        let!(:user) {FactoryGirl.build(:user)}
        let!(:comment) {FactoryGirl.create(:comment)}
        before do
            sign_in user
        end

        context 'When successfully delete an existing comment' do
            it 'should delete the comment from the database and redirect to the event detail page' do
                delete :destroy, {:id => comment.id, :event_id => event.id}
                expect(event.comments.count).to equal(0)
                expect(user.comments.count).to equal(0)
                expect(response).to redirect_to(event_path(event))
            end
        end
    end

    describe '#react' do
        let!(:event) {FactoryGirl.create(:event)}
        let!(:user) {FactoryGirl.create(:user)}
        let!(:comment) {FactoryGirl.create(:comment)}
        before do
            sign_in user
        end

        context 'When successfully react thumbup to a comment' do
            it 'should show the current reaction in the same page and cancel the reaction if reacted again' do
                put :react, {:id => comment.id, :event_id => event.id, :action_id => 0}
                expect(comment.reactions.count).to equal(1)
                expect(user.reactions.count).to equal(1)
                expect(response).to redirect_to(event_path(event))
                put :react, {:id => comment.id, :event_id => event.id, :action_id => 0}
                expect(comment.reactions.count).to equal(0)
                expect(user.reactions.count).to equal(0)
                expect(response).to redirect_to(event_path(event))
            end
        end
    end
end
end