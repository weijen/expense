require 'spec_helper'

describe GroupTagsController do

  #Delete these examples and add some real ones
  it "should use GroupTagsController" do
    controller.should be_an_instance_of(GroupTagsController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
end
