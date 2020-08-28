require 'spec_helper'


describe "ApplicationController" do
    
    describe "Form" do
  
      it "posts to /home" do
        visit '/login'
  
        fill_in :username, :with => "person"
        fill_in :password, :with => "word"
  
        page.find(:css, "[type=submit]").click
  
        expect(page.current_path).to eq("/home")
        expect(params).to include("login")
      end
    end 
end 