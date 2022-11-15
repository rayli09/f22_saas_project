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
    let!(:user) {FactoryGirl.build(:user)}
    it "signs up a new user and go to welcome" do
      post :create, {:user=>{:username=>user.username,:password=>user.password}}
      expect(response).to redirect_to '/welcome'
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

end
