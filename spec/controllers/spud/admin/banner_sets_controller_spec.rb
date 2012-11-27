require 'spec_helper'

describe Spud::Admin::BannerSetsController do

  before(:each) do
    activate_authlogic
    u = SpudUser.new(:login => "testuser",:email => "test@testuser.com",:password => "test",:password_confirmation => "test")
    u.super_admin = true
    u.save
    @user = SpudUserSession.create(u)
  end

  describe :index do
    it "should return an array of banner sets" do
      5.times do |x| 
        banner_set = FactoryGirl.create(:spud_banner_set)
      end
      get :index
      assigns(:banner_sets).count.should be > 1
    end
  end

  describe :show do
    it "should respond with a banner set" do
      banner_set = FactoryGirl.create(:spud_banner_set)
      get :show, :id => banner_set.id
      assigns(:banner_set).should == banner_set
      response.should be_success
    end

    it "should redirect if banner set is not found" do
      get :show, :id => -1
      assigns(:banner_set).should be_blank
      response.should redirect_to spud_admin_banner_sets_path
    end
  end

  describe :new do
    it "should respond with a banner set" do
      get :new
      assigns(:banner_set).should_not be_blank
      response.should be_success
    end
  end

  describe :create do
    it "should respond with a banner set" do
      lambda {
        post :create, :spud_banner_set => FactoryGirl.attributes_for(:spud_banner_set)
      }.should change(SpudBannerSet, :count).by(1)
      response.should be_success
    end

    it "should respond unsuccessfully if the banner set is invalid" do
      lambda {
        post :create, :spud_banner_set => {:name => '', :width => 'lorem', :height => 'ipsum'}
      }.should_not change(SpudBannerSet, :count)
      assert_response 422
    end
  end

  describe :edit do
    it "should respond with a banner set" do
      banner_set = FactoryGirl.create(:spud_banner_set)
      get :edit, :id => banner_set.id
      assigns(:banner_set).should == banner_set
      response.should be_success
    end
  end

  describe :update do
    it "should update the banner set" do
      banner_set = FactoryGirl.create(:spud_banner_set)
      new_name = "Updated Set Name"
      lambda {
        put :update, :id => banner_set.id, :spud_banner_set => {:name => new_name}
        banner_set.reload
      }.should change(banner_set, :name).to(new_name)
    end

    it "should respond unsuccessfully if the updated banner set is invalid" do
      banner_set = FactoryGirl.create(:spud_banner_set)
      lambda {
        put :update, :id => banner_set.id, :spud_banner_set => {:name => '', :width => 'lorem', :height => 'ipsum'}
      }.should_not change(SpudBannerSet, :count)
      assert_response 422
    end
  end

  describe :destroy do
    it "should destroy the banner set and respond successfully" do
      banner_set = FactoryGirl.create(:spud_banner_set)
      lambda {
        delete :destroy, :id => banner_set.id
      }.should change(SpudBannerSet, :count).by(-1)
      response.should be_success
    end
  end

end