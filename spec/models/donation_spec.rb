require 'rails_helper'

RSpec.describe Donation, :type => :model do
  describe '#create' do
  	it 'should always have an amount of 1' do 
  		donation = Donation.create()
  		expect(donation.amount).to eq('1')
  	end
  end
end
