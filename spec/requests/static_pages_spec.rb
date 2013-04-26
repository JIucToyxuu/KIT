require 'spec_helper'

describe "StaticPages" do

  describe "Home page" do

    it "should have the h1 'Keep In Touch'" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text => 'Keep In Touch')
    end

  	it "should have tne content 'KIT'" do
  		visit '/static_pages/home'
  		page.should have_selector('title', :text => "Keep In Touch | Home")
  	end
  end

describe "Help page" do

    it "should have the h1 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('h1', :text => 'Help')
    end

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('title', :text => 'Keep In Touch | Help')
    end

  end

  describe "About page" do

    it "should have the h1 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('h1', :text => 'About Us')
    end

    it "should have tne content 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('title', :text => "Keep In Touch | About Us")
    end
  end


end
