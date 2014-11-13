class DonationsController < ApplicationController
  def index
  end

  def create
  
  	@response = HTTParty.post("http://usapisandbox.fgdev.net/donation/creditcard", 
  		{:body => {"cardOnFileId" => current_user.card_token, "amount" => 5.00, "charityId" => params[:nonprof], "description" => "Give a little donation", "currencyCode" => "USD", "remoteAddr" => "127.0.0.1"}, 
  		 :headers => {"JG_APPLICATIONKEY" => ENV['JG_APPLICATIONKEY'], "JG_SECURITYTOKEN" => ENV['JG_SECURITYTOKEN']}})

  	if @response.parsed_response["firstGivingDonationApi"]["firstGivingResponse"]["acknowledgement"] == "Success"
  		Donation.create(user: current_user, nonprofit: Nonprofit.find(params[:nonprofit]), amount: 5)
  		redirect_to root_path
  	else
  		redirect_to nonprofits_path
  		#Add flash error
  	end
  end

  def show
  end
end
