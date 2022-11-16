require 'rails_helper'
require 'ostruct'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "should render sign up page" do
      get :new
      expect(response).to render_template 'new'
    end
  end

  describe "POST #create" do
    let!(:user) {FactoryGirl.create(:user)}

    context "When successfully create a new user" do
      it "should store the new user in the database and go to welcome" do
        params = ActionController::Parameters.new(:username => "smartuser", :password => "hahaha")
        expect{post :create, {:user => params}}.to change{User.count}.by(1)
        expect(response).to redirect_to '/welcome'
      end
    end

    context "When fails to create a new user due to duplicate username" do
      it "should not store the new user in the database and go to new user page" do
        params = ActionController::Parameters.new(:username => "testuser", :password => "test")
        expect{post :create, {:user => params}}.to change{User.count}.by(0)
        expect(response).to redirect_to '/users/new?'
      end
    end

    context "When fails to create a new user due to empty username" do
      it "should not store the new user in the database and go to new user page" do
        params = ActionController::Parameters.new(:password => "test")
        expect{post :create, {:user => params}}.to change{User.count}.by(0)
        expect(response).to redirect_to '/users/new?'
      end
    end
  end

  describe "GET #show"  do
    let!(:user) {FactoryGirl.create(:user)}
    before do
      sign_in user
      existing_user = User.create({:username => "smartuser", :password =>"smart123", :email => "smartuser@gmail.com"})
      get :show, {:id => existing_user.id}
    end

    context 'When go to the user profile page' do
      it 'should not be host' do
        expect(assigns(:is_viewer_user)).to eq(false)
      end

      it 'should render show template' do
        expect(response).to render_template('show')
      end
    end
  end

  describe "GET #myProfile" do
    let!(:user) {FactoryGirl.create(:user)}
    before do
      sign_in user
      get :myProfile
    end

    context "When go to the myProfile page" do
      it "should redirect to current user's profile page" do
        expect(response).to redirect_to(user_path(user))
      end
    end
  end

  describe "GET #edit" do
    let!(:user) {FactoryGirl.create(:user)}
    before do
      sign_in user
      get :edit, {:id => user.id}
    end

    context "When go to the edit user profile page" do
      it "should render edit user template" do
        expect(assigns(:user)).to eq(user)
        expect(response).to render_template('edit')
      end
    end
  end

  describe "PUT #update" do
    let!(:user) {FactoryGirl.create(:user)}
    before do
      sign_in user
    end

    context "When successfully update an existing user profile" do
      it "should store the update in the database and redirect to user profile page" do
        params = ActionController::Parameters.new(:email => "testuserlol@gmail.com")
        put :update, {:id => user.id, :user => params}
        user.reload
        expect(user.email).to eq("testuserlol@gmail.com")
        expect(response).to redirect_to(user_path(user))
      end
    end

    context "When failed to update an existing user profile due to invalid email format" do
      it "should not change user info in the database and redirect to edit user profile page" do
        params = ActionController::Parameters.new(:email => "testuserlol")
        put :update, {:id => user.id, :user => params}
        user.reload
        expect(user.email).to eq("")
        expect(response).to redirect_to(edit_user_path(user))
      end
    end
  end

  describe "user controller omniauth" do
    let!(:user) {FactoryGirl.build(:user)}
    it "should invoke self.from_omniauth" do
    auth = OpenStruct.new(
      {:info => OpenStruct.new(
        {:name => 'testuser', :email => 'test@test.com'})
      })
    result = User.from_omniauth(auth)
    expect(result.username ).to eq 'testuser'
    expect(result.email ).to eq 'test@test.com'
    end
  end

  describe "PUT #rateUser" do
    let!(:event) {FactoryGirl.create(:event)}
    let!(:user) {FactoryGirl.build(:user, username: 'David')}
    before do
      sign_in user
      put :rateUser, {:id => event.id}
    end

    context "When successfully update an existing user profile" do
      it "should store the update in the database and redirect to user profile page" do
        # rating = ActionController::Parameters.new(:David => "1")
        put :rateUser, {:id => event.id, :David => "1"}
        user.reload
        expect(user.rating).to eq(1)
        expect(response).to redirect_to("/events/1")
      end
    end
  end

end
