class ChargesController < ApplicationController
def new
end

def create

  # Amount in cents
  @amount = 100

  customer = Stripe::Customer.create(
    :email => 'example@stripe.com',
    :card  => params[:stripeToken]
  )

  token = Stripe::Token.create(
  {:customer => customer.id},
  Nonprofit.find(params[:nonprof]).oauth # user's access token from the Stripe Connect flow
  )

  charge = Stripe::Charge.create(
    :card    => token.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
  )

Donation.create(user: current_user, nonprofit: Nonprofit.find(params[:nonprof]))
# Set your secret key: remember to change this to your live secret key in production
# See your keys here https://dashboard.stripe.com/account
redirect_to user_path(current_user)
rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to charges_path
end
end
