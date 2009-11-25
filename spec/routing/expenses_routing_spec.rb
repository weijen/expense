require 'spec_helper'

describe ExpensesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/expenses" }.should route_to(:controller => "expenses", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/expenses/new" }.should route_to(:controller => "expenses", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/expenses/1" }.should route_to(:controller => "expenses", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/expenses/1/edit" }.should route_to(:controller => "expenses", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/expenses" }.should route_to(:controller => "expenses", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/expenses/1" }.should route_to(:controller => "expenses", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/expenses/1" }.should route_to(:controller => "expenses", :action => "destroy", :id => "1") 
    end
  end
end
