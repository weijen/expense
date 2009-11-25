require 'spec_helper'

describe "/group_expenses/delete" do
  before(:each) do
    render 'group_expenses/delete'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/group_expenses/delete])
  end
end
