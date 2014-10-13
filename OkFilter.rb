# OkFilter

require 'highline/import'
require 'watir-webdriver'

class OkFilter 
	def initialize(name, pass, lower_bound=60, upper_bound=90)
		@name = name
		@pass = pass
		@lower_bound = lower_bound
		@upper_bound = upper_bound
		@matched = 0
		@rejected = 0
		@skipped = 0
		@total = 0
	end
	
	def login 
		puts "Logging in..." if VERBOSE
		@b = Watir::Browser.new
		@b.goto 'http://www.okcupid.com/'
		@b.link(:id, "open_sign_in_button").click
		sleep 1 
		@b.text_field(:id, 'login_username').set @name
		@b.text_field(:id, 'login_password').set @pass
		@b.button(:id, 'sign_in_button').click
		sleep 3
	end
	
	def goto_quickmatch
		puts "Going to Quickmatch..." if VERBOSE
		quickmatch_url = 'http://www.okcupid.com/quickmatch'
		@b.goto quickmatch_url
	end
	
	def rate_quickmatch
		match_percentage = @b.span(:class => 'percent').text.to_i
		total += 1
		if match_percentage >= 90
			@matched += 1
			b.link(:text => '5 star rating').click
		elsif match_percentage <= 70
			@rejected += 1
			b.link(:text => '1 star rating').click
		else
			b.link(:text => 'Skip').click
			@skipped += 1
		end

		puts "Matched: #{@matched}/#{@total} (#{(@matched.to_f/@total*100).to_i}%)\tRejected:#{@rejected}/#{@total} (#{(@rejected.to_f/@total*100).to_i}%)" if VERBOSE
		sleep 1
	end
end

# If running as command line script:

abort unless __FILE__ == "OkFilter.rb"

name = ask "What's your OKC name? "
pass = ask("Password? ") { |q| q.echo = false }

VERBOSE = ARGV.include? "-v"

okc = OkFilter.new name, pass

# Log in:
okc.login

# Go to Quickmatch:
okc.goto_quickmatch

# Start rating!
while true do
	okc.rate_quickmatch
end
