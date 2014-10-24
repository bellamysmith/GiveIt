require 'rails_helper'

RSpec.describe Nonprofit, :type => :model do
  describe "#create" do 
  	it "should have an email and password" do 
  		nonprof = Nonprofit.create(email: "blah@blah.com", password: "blahblah", oauth: "example")
  		expect(nonprof).to be_valid
  		nonprof = Nonprofit.create(email: "blah@blah.com")
  		expect(nonprof).to be_invalid
  	end
  	it "should have an oauth code" do
  		nonprof = Nonprofit.create(email: "blah@blah.com", password: "blahblah")
  		expect(nonprof).to be_invalid
  	end
  end

  describe "#update" do
  	it "should have a main topics" do
  		nonprof = Nonprofit.create(email: "blah@blah.com", password: "blahblah", oauth: "example")
  		expect(nonprof.update(website: 'example.com', main_topic: "1")).to be_truthy
  	end
  end


end
