require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
    describe 'helper methods' do
        let!(:user) {FactoryGirl.build(:user)}
        # context 'when get current user if user signed in' do
            it 'should return the current user' do
                expect(User).to receive(:find_by).and_return(user)
                assert_equal user, @controller.current_user
            end
            it 'should return nil if user is not signed in' do
                expect(User).to receive(:find_by).and_return(nil)
                assert_equal nil, @controller.current_user
            end
            it 'should return true if current user signed in' do
                expect(User).to receive(:find_by).and_return(user)
                assert_equal true, @controller.logged_in?
            end
            it 'should return false if current user is out' do
                expect(User).to receive(:find_by).and_return(nil)
                assert_equal false, @controller.logged_in?
            end
        # end
    end
end