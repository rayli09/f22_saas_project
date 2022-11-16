require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
# describe SessionsController do
  describe "GET #new" do
    it "goes to the login page" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    let!(:user) {FactoryGirl.build(:user)}
    # before do
    #   sign_in user
    #   post :create, {:username=>user.username, :password=>user.password}
    # end
    it "redirects to welcome if user validates" do
      sign_in user
      post :create, {:username=>user.username, :password=>user.password}
      expect(response).to redirect_to '/welcome'
    end
    it "redirects to login if user fails to validate" do
      post :create, {:username=>user.username, :password=>user.password}
      expect(response).to redirect_to '/login'
    end
    it "fails to login due to empty fields" do
      sign_in user
      post :create, {:username=>user.username, :password=>nil}
      expect(flash[:warning]).to be_present
      expect(response).to redirect_to '/login'
    end
  end

  describe "GET #welcome" do
    it "should goto welcome page for login/signup" do
      get :welcome
      expect(response).to render_template("welcome")
    end
  end
  
  describe "GET #logout" do
    let!(:user) {FactoryGirl.build(:user)}
    before do
      sign_in user
    end
    it "should logs out and goes back to welcome" do
      get :logout
      expect(response).to redirect_to '/welcome'
      expect(response).to_not include 'testuser'
    end
  end

  describe "omniauth SSO" do
    let!(:user) {FactoryGirl.build(:user)}
    before do
      allow(User).to receive(:from_omniauth).and_return(user)
      expect(user).to receive(:save).and_return(user)
    end
    it "should call omiauth to perform SSO" do
      get :omniauth, {provider: 'google_oauth2'}
      expect(response).to redirect_to '/welcome'
    end
  end


end
