# OkFilter

require 'mechanize'
require 'highline/import'
require 'watir'
require 'watir-webdriver'

a = Mechanize.new
name = ask "What's your OKC name? "
pass = ask("Password? ") { |q| q.echo = false }

a.get 'http://www.okcupid.com/login'

login_form = a.page.form[2]

login_form['username'] = name
login_form['password'] = pass
login_form.submit

quickmatch_url = 'http://www.okcupid.com/quickmatch'

a.get quickmatch_url

# Scan page for match percentage
# OKC puuts it in a <span class="percent"></span> but loads it with
# javascript. The result is... hmm... how to get?

match_percentage = 80

if match_percentage >= 90
	a.page.link_with(:text => "5 star rating").click
elsif match_percentage <= 60
	a.page.link_with(:text => "1 star rating").click
else 
	a.page.link_with(
end
