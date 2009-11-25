require 'spec_helper'

describe ExpensesController do

  def mock_expense(stubs={})
    @mock_expense ||= mock_model(Expense, stubs)
  end

  describe "GET index" do
    it "assigns all expenses as @expenses" do
      Expense.stub!(:find).with(:all).and_return([mock_expense])
      get :index
      assigns[:expenses].should == [mock_expense]
    end
  end

  describe "GET show" do
    it "assigns the requested expense as @expense" do
      Expense.stub!(:find).with("37").and_return(mock_expense)
      get :show, :id => "37"
      assigns[:expense].should equal(mock_expense)
    end
  end

  describe "GET new" do
    it "assigns a new expense as @expense" do
      Expense.stub!(:new).and_return(mock_expense)
      get :new
      assigns[:expense].should equal(mock_expense)
    end
  end

  describe "GET edit" do
    it "assigns the requested expense as @expense" do
      Expense.stub!(:find).with("37").and_return(mock_expense)
      get :edit, :id => "37"
      assigns[:expense].should equal(mock_expense)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created expense as @expense" do
        Expense.stub!(:new).with({'these' => 'params'}).and_return(mock_expense(:save => true))
        post :create, :expense => {:these => 'params'}
        assigns[:expense].should equal(mock_expense)
      end

      it "redirects to the created expense" do
        Expense.stub!(:new).and_return(mock_expense(:save => true))
        post :create, :expense => {}
        response.should redirect_to(expense_url(mock_expense))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved expense as @expense" do
        Expense.stub!(:new).with({'these' => 'params'}).and_return(mock_expense(:save => false))
        post :create, :expense => {:these => 'params'}
        assigns[:expense].should equal(mock_expense)
      end

      it "re-renders the 'new' template" do
        Expense.stub!(:new).and_return(mock_expense(:save => false))
        post :create, :expense => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested expense" do
        Expense.should_receive(:find).with("37").and_return(mock_expense)
        mock_expense.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :expense => {:these => 'params'}
      end

      it "assigns the requested expense as @expense" do
        Expense.stub!(:find).and_return(mock_expense(:update_attributes => true))
        put :update, :id => "1"
        assigns[:expense].should equal(mock_expense)
      end

      it "redirects to the expense" do
        Expense.stub!(:find).and_return(mock_expense(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(expense_url(mock_expense))
      end
    end

    describe "with invalid params" do
      it "updates the requested expense" do
        Expense.should_receive(:find).with("37").and_return(mock_expense)
        mock_expense.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :expense => {:these => 'params'}
      end

      it "assigns the expense as @expense" do
        Expense.stub!(:find).and_return(mock_expense(:update_attributes => false))
        put :update, :id => "1"
        assigns[:expense].should equal(mock_expense)
      end

      it "re-renders the 'edit' template" do
        Expense.stub!(:find).and_return(mock_expense(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested expense" do
      Expense.should_receive(:find).with("37").and_return(mock_expense)
      mock_expense.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the expenses list" do
      Expense.stub!(:find).and_return(mock_expense(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(expenses_url)
    end
  end

end
