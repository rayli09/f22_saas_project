require 'rails_helper'

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

end
