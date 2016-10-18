require 'sinatra'
require 'stripe'

Stripe.api_key = "sk_test_0dbVBNRNaiYYFZIRLzZQFeqY" # use your own keys

get '/' do
  erb :index
end

post '/charge' do
  # Amount in cents
  @amount = 500

  # Create customer
  customer = Stripe::Customer.create(
    :email => 'customer@example.com',
    :source  => params[:stripeToken]
  )

  # Create charge
  charge = Stripe::Charge.create(
    :amount      => @amount,
    :description => 'Sinatra Charge',
    :currency    => 'usd',
    :customer    => customer.id
  )

  erb :charge

  #error Stripe::CardError do
	#  env['sinatra.error'].message
	#end
end

