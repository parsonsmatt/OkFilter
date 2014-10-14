# OkShoes -- Shoes GUI for OkFilter!

require 'OkFilter'

Shoes.app(title: "OkFilter") do
	stack( margin: 20 ) do
		title "OkFilter!"
		para "v0.3.0"
		flow do
			para "OKC Username:" 
			@username = edit_line 
		end 
		flow do
			para "Password: "
			@password = edit_line :secret => true
		end
		flow do
			para "Likes matches over: "
			@like = edit_line.text = "90"
		end
		flow do
			para "Filter matches under: "
			@filter = edit_line.text = "60"
		end
		flow do
			@go = button "Go!!"
			@stop = button "Stop!!"
		end
	end # end stack
	# program logic
	@keep_going = true
	
	@stop.click do
		@keep_going = false;
	end
	
	@go.click do
		keep_going = true;	 
		okc = OkFilter.new @username.text, 
											 @password.text,
											 @filter.to_i,
											 @like.to_i
		okc.login
		okc.goto_quickmatch
		while @keep_going do
			okc.rate_quickmatch
		end
	end
end
