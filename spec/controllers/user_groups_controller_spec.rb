require 'spec_helper'

describe UserGroupsController do

  #Delete these examples and add some real ones
  it "should use UserGroupsController" do
    controller.should be_an_instance_of(UserGroupsController)
  end


  describe "GET 'create'" do
    it "should be successful" do
      get 'create'
      response.should be_success
    end
  end
end
