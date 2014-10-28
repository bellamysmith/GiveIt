require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "#update" do
  	it 'should have a normalized name' do 
  		user = User.create(email: 'example@example.com', password: "blahblah", first_name: "bellamy", last_name: "smith")
  		expect(user.name).to eq("Bellamy Smith")
  	end
  	it 'should be able to have topics' do
  		user = User.create(email: 'example@example.com', password: "blahblah", first_name: "bellamy", last_name: "smith", topics: [Topic.first, Topic.last])
  		expect(user).to be_valid
  	end
  	it 'should have nonprofits based on topics' do 
  		user = User.create(email: 'example@example.com', password: "blahblah", first_name: "bellamy", last_name: "smith", topics: [Topic.first, Topic.last])
  		nonprof = Nonprofit.create(email: 'nonprof@nonprof.com', password: "blahblah", topics: [Topic.first, Topic.last], oauth: "Something")
  		expect(user.interested).to  include(nonprof)	
  	end
  	it 'should have nonprofits through donations' do
  		user = User.create(email: 'example2@example.com', password: "blahblah", first_name: "bellamy", last_name: "smith")
  		nonprof = Nonprofit.create(email: 'nonprof@nonprof.com', password: "blahblah", topics: [Topic.first, Topic.last], oauth: "Something" )
		Donation.create(nonprofit: nonprof, user: user)
		expect(user.nonprofits).to include(nonprof)
	end
  end
end
