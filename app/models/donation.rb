class Donation < ActiveRecord::Base
  belongs_to :user
  belongs_to :nonprofit

  before_create :set_amount

  def set_amount
  	self.amount = "1"
  end
end
