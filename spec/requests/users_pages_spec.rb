require 'spec_helper'

describe "UsersPages" do
  describe "Sign Up" do
    it "allows the user to fill in name and password" do
      visit '/users/new'
      fill_in 'username', with: 'user@example.com'
      fill_in 'password', with: 'password'
      fill_in 'confirmation', with: 'password'
      click_button 'submit'
    end
  end
end
