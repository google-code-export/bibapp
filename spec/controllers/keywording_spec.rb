require File.dirname(__FILE__) + '/../spec_helper'

describe KeywordingsController do

  before(:each) do
    @keywording = Factory.create(:keywording)
  end

  it "should get index" do
    get :index
    response.should be_success
    assigns(:keywordings).should_not be_nil
  end

  it "should get show" do
    get :show, :id => @keywording.id
    response.should be_success
  end

  context "logged in" do
    before(:each) do
      login_as(:quentin)
    end

    it "should get new" do
      get :new
      response.should be_success
    end

    it "should create" do
      keyword = Factory.create(:keyword)
      assert_difference('Keywording.count') do
        post :create, :keywording => {:keyword_id => keyword.id, :work_id => @keywording.work.id}
      end
      response.should redirect_to(keywording_url(assigns(:keywording)))
    end

    it "should get edit" do
      get :edit, :id => @keywording.id
      response.should be_success
    end

    it "should update"  do
      put :update, :id => @keywording.id, :keywording => {}
      response.should redirect_to(keywording_url(:id => @keywording.id))
    end

    it "should destroy" do
      assert_difference('Keywording.count', -1) do
        delete :destroy, :id => @keywording.id
      end
      response.should redirect_to(keywordings_url)
    end
  end
end