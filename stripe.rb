require 'sinatra'
require 'stripe'

#set :publishable_key, ENV['pk_test_WxmqvoiqGGzZqwgACqm0Meen'] # PUBLISHABLE_KEY
#set :secret_key, ENV['sk_test_0dbVBNRNaiYYFZIRLzZQFeqY'] # SECRET_KEY
Stripe.api_key = "sk_test_0dbVBNRNaiYYFZIRLzZQFeqY"

get '/' do
  erb :index
end

post '/charge' do
  # Amount in cents
  @amount = 500

  customer = Stripe::Customer.create(
    :email => 'customer@example.com',
    :source  => params[:stripeToken]
  )

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

