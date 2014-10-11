# OkFilter

require 'mechanize'
require 'highline/import'
require 'watir'
require 'watir-webdriver'

name = ask "What's your OKC name? "
pass = ask("Password? ") { |q| q.echo = false }

b = Watir::Browser.new

# Log in:
b.goto 'http://www.okcupid.com/'
b.link(:id, "open_sign_in_button").click
sleep 3
b.text_field(:id, 'login_username').set name
b.text_field(:id, 'login_password').set pass
b.button(:id, 'sign_in_button').click
sleep 3

# Go to Quickmatch:
quickmatch_url = 'http://www.okcupid.com/quickmatch'
b.goto quickmatch_url

sleep 5

# Start rating!
for num in 1..100 do
	match_percentage = b.span(:class => 'percent').text.to_i
	
	if match_percentage >= 90
		b.link(:text => '5 star rating').click
	elsif match_percentage <= 70
		b.link(:text => '1 star rating').click
	else
		b.link(:text => 'Skip').click
	end

	sleep 2
end
