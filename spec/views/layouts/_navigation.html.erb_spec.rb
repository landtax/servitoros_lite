require 'spec_helper'

describe "layouts/_navigation.html.erb" do

  let(:user) { create(:user) }

  describe "menu" do
    it "shows options when user is signed_in" do
      view.stub(:user_signed_in?).and_return(true)
      view.stub(:current_user).and_return(user)
      render
      rendered.should have_selector("ul.nav li", :count => 3)
    end

    it "does not show options when user is not signed_in" do
      view.stub(:user_signed_in?).and_return(false)
      render 
      rendered.should_not have_selector("ul.nav li")
    end
  end

end
