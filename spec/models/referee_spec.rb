require 'spec_helper'

describe Referee do
  let (:referee) { FactoryGirl.create(:referee) }
  subject { referee }

  it { should respond_to(:file_location) }
  it { should respond_to(:name) }
  it { should respond_to(:rules_url) }
  it { should respond_to(:players_per_game) }
  it { should respond_to(:contests) }
  it { should respond_to(:matches) }
  it { should respond_to(:user) }

  describe "validations" do
    it { should be_valid }
  end

  describe "empty file location" do
    before { referee.file_location = '' }
    it { should_not be_valid }
  end

  describe "blank file location" do
    before { referee.file_location = ' ' }
    it { should_not be_valid }
  end

  describe "empty name" do
    before { referee.name = '' }
    it { should_not be_valid }
  end

  describe "blank name" do
    before { referee.name = ' ' }
    it { should_not be_valid }
  end

  describe "empty rules_url" do
    before { referee.rules_url = '' }
    it { should_not be_valid }
  end

  describe "blank rules_url" do
    before { referee.rules_url = ' ' }
    it { should_not be_valid }
  end

  #
  # example URLs from
  # http://stackoverflow.com/questions/161738/what-is-the-best-regular-expression-to-check-if-a-string-is-a-valid-url
  #

  describe "various url formats" do
    describe "poorly formed urls" do
      urls = %w[www..dr.google
		www.dr.google..com]

      broken_urls = %w[javascript:alert('xss')
		www:google.com
		https://www@.google.com
		https://www.google.com\
		https://www.google.com'
		http://www.google.com/path'
		http://subdomain.web-site.com/cgi-bin/perl.cgi?key1=value1&key2=value2e'
		http://www.google.com/?queryparam=123'
		http://www.google.com/path?queryparam=12'3]
      urls.each do |invalid_url|
	it "is invalid" do
	  referee.rules_url = invalid_url
	  expect(referee).not_to be_valid
	end
      end

      broken_urls.each do |invalid_url|
	pending "is invalid" do
	  referee.rules_url = invalid_url
	  expect(referee).not_to be_valid
	end
      end
    end
    describe "properly formed urls" do
      urls = %w[http://www.example.com
		http://www.regexbuddy.com
		http://www.regexbuddy.com/
		http://www.regexbuddy.com/index.html
		http://www.regexbuddy.com/index.html?source=library
		http://www.google.com
		http://www.google.co.uk
		https://www.google.com
		https://www.google.co.uk
		http://google.com
		http://google.com/help.php
		http://google.com/help.php?a=5
		http://www.google.com/help.php
		http://www.google.com?a=5
		http://www.m.google.com/help.php?a=5
		http://www.google.com/path
		http://subdomain.web-site.com/cgi-bin/perl.cgi?key1=value1&key2=value2e
		http://www.google.com/?queryparam=123
		http://www.google.com/path?queryparam=123]

      broken_urls = %w[www.google.com
		www.google.co.uk
		google.com
		google.co.uk
		google.mu
		mes.intnet.mu
		cse.uom.ac.mu
		google.com?a=5
		google.com/help.php
		google.com/help.php?a=5
		www.m.google.com/help.php?a=5
		m.google.com/help.php?a=5]
      urls.each do |valid_url|
	it "is valid" do
	  referee.rules_url = valid_url
	  expect(referee).to be_valid
	end
      end

      broken_urls.each do |valid_url|
	pending "is valid" do
	  referee.rules_url = valid_url
	  expect(referee).to be_valid
	end
      end
    end
  end

  describe "empty players per game" do
    before { referee.players_per_game = '' }
    it { should_not be_valid }
  end

  describe "blank players per game" do
    before { referee.players_per_game = ' ' }
    it { should_not be_valid }
  end

  describe "wordy players per game" do
    before { referee.players_per_game = 'two' }
    it { should_not be_valid }
  end

  describe "zero players per game" do
    before { referee.players_per_game = 0 }
    it { should_not be_valid }
  end

  describe "negative players per game" do
    before { referee.players_per_game = -1 }
    it { should_not be_valid }
  end

  describe "large players per game" do
    before { referee.players_per_game = 10 }
    it { should be_valid }
  end

  describe "too large players per game" do
    before { referee.players_per_game = 11 }
    it { should_not be_valid }
  end
end