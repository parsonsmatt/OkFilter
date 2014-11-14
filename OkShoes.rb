# OkShoes -- Shoes GUI for OkFilter!

require_relative './OkFilter'

Shoes.app(title: "OkFilter", width: 350, height: 250) do
	stack( margin: 20, align: 'right' ) do
		title "OkFilter!", align: 'center'
		para "v0.3.0", align: 'center'
		flow align: 'center' do
			para "OKC Username:" 
			@username = edit_line :width => 120, :right => 20
		end 
		flow do
			para "Password: " 
			@password = edit_line :secret => true, :width => 120, :right => 20 
		end
		flow do
			para "Likes matches over: "
			@like = edit_line(:width => 80, :right => 20).text = "90"
		end
		flow do
			para "Filter matches under: "
			@filter = edit_line(:width => 80, :right => 20).text = "60"
		end
		flow do 
			@go = button "Go!!", :width => 80, :left => 40
			@stop = button "Stop!!", :width => 80, :right => 40
		end
	end # end stack

	# program logic
	@keep_going = true
	
	@stop.click do
		@keep_going = false;
	end
	
	@go.click do
		okc = OkFilter.new @username.text, 
						   @password.text,
						   @filter.to_i,
						   @like.to_i
		Thread.new do
			@keep_going = true;	 
			okc.login
			okc.goto_quickmatch
			while @keep_going do
				okc.rate_quickmatch
			end
			okc.close
		end
	end
end
