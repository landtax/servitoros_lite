require 'spec_helper'

describe "layouts/application.html.erb" do

  let(:user) { create(:user) }

  describe "devise controls" do
    it "shows signup when not current user" do
      view.stub(:user_signed_in?).and_return(false)
      render 
      rendered.should have_selector("#btn_signup")
      rendered.should have_selector("#btn_signin")
      rendered.should_not have_selector("#btn_user_settings")
      rendered.should_not have_selector("#btn_signout")
    end

    it "shows current user buttons when user is signed_in" do
      view.stub(:user_signed_in?).and_return(true)
      view.stub(:current_user).and_return(user)
      render 
      rendered.should_not have_selector("#btn_signup")
      rendered.should_not have_selector("#btn_signin")
      rendered.should have_selector("#btn_user_settings")
      rendered.should have_selector("#btn_signout")
    end
  end
end
