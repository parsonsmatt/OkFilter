#! /usr/bin/env ruby
# OkFilter

require 'highline/import'
require 'watir-webdriver'

VERBOSE = false;

class OkFilter 
	def initialize(name, pass, filter, like)
		@name = name
		@pass = pass
		@filter = filter || 60
		@like = like || 90
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
		@total += 1
		if match_percentage >= @like
			@matched += 1
			@b.link(:text => '5 star rating').click
		elsif match_percentage <= @filter && match_percentage > 0 # 0 might mean that they haven't filled out their profile yet!
			@rejected += 1
			@b.link(:text => '1 star rating').click
		else
			@b.link(:text => 'Skip').click
			@skipped += 1
		end

		puts "Matched: #{@matched}/#{@total} (#{(@matched.to_f/@total*100).to_i}%)\tRejected:#{@rejected}/#{@total} (#{(@rejected.to_f/@total*100).to_i}%)" if VERBOSE
		sleep 1
	end
end

if  __FILE__ == $0

	help_message = "Usage: OkFilter.rb [-h][-v][-u username][-F filter_below_match][-L like_above_match]\n\n" +
			   "-h\tDisplays usage help.\n"+
			   "-v\tVerbose logging.\n" +
				 "-u\tUsername. If nothing here, will prompt for it.\n" +
				 "-F\tFilters matches if their match % is lower than this number. Default 60\n" +
				 "-L\tLikes matches if their match % is above this number. Default 90\n"

	if ARGV.include? "-h"
		abort help_message
	end

	VERBOSE = ARGV.include? "-v"
	DEFAULT_LOWER = 60
	DEFAULT_UPPER = 90

	name = ARGV[ARGV.index("-u") + 1].to_s if ARGV.include? "-u" || ask("What's your OKC name? ")
	lower = ARGV[ARGV.index("-F")+ 1].to_i if ARGV.include? "-F" || DEFAULT_LOWER
	upper = ARGV[ARGV.index("-L") + 1].to_i if ARGV.include? "-L" || DEFAULT_UPPER

	name ||= ask "What's your OKC name? "

	pass = ask("Password? ") { |q| q.echo = false }

	okc = OkFilter.new name, pass, lower, upper

	# Log in:
	okc.login

	# Go to Quickmatch:
	okc.goto_quickmatch

	# Start rating!
	while true do
		okc.rate_quickmatch
	end
end
