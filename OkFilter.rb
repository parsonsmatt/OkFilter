# OkFilter

require 'mechanize'
require 'highline/import'
require 'watir'
require 'watir-webdriver'


name = ask "What's your OKC name? "
pass = ask("Password? ") { |q| q.echo = false }

VERBOSE = ARGV.include? "-v"

b = Watir::Browser.new

# Log in:
puts "Logging in..." if VERBOSE
b.goto 'http://www.okcupid.com/'
b.link(:id, "open_sign_in_button").click
sleep 1 
b.text_field(:id, 'login_username').set name
b.text_field(:id, 'login_password').set pass
b.button(:id, 'sign_in_button').click
sleep 3

# Go to Quickmatch:
puts "Going to Quickmatch..." if VERBOSE
quickmatch_url = 'http://www.okcupid.com/quickmatch'
b.goto quickmatch_url

sleep 3 

matched = 0
rejected = 0
total = 0

# Start rating!
while true do
	match_percentage = b.span(:class => 'percent').text.to_i
	total += 1
	if match_percentage >= 90
		matched += 1
		b.link(:text => '5 star rating').click
	elsif match_percentage <= 70
		rejected += 1
		b.link(:text => '1 star rating').click
	else
		b.link(:text => 'Skip').click
	end

	puts "Matched: #{matched}/#{total} (#{(matched.to_f/total*100).to_i}%)\tRejected:#{rejected}/#{total} (#{(rejected.to_f/total*100).to_i}%)" if VERBOSE
	sleep 1
end
