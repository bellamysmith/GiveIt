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
  	it 'should be able to have a main topic, and many other topics' do 
  		nonprof = Nonprofit.create(email: "blah@blah.com", password: "blahblah", oauth: "example")
  		expect(nonprof.update(topics: [Topic.first, Topic.last], main_topic: "3")).to be_truthy
  	end
  end

  it "should be related to a user, if it has a donation from that user" do
    nonprof = Nonprofit.create(email: "blah@blah.com", password: "blahblah", oauth: "example")
    user = User.create(email: 'example@example.com', password: "blahblah")
    Donation.create(nonprofit: nonprof, user: user)
    expect(user.nonprofits).to include(nonprof)
  end

  describe '.main' do
  	it 'should return the main topic name' do
  		nonprof = Nonprofit.create(email: "blah@blah.com", password: "blahblah", oauth: "example", main_topic: Topic.last.id)
  		expect(nonprof.main).to eq(Topic.last.topic)
  	end
  end



end
