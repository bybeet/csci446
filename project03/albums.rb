require 'rack'

class Top100Albums
	
	def initialize
		@info = Array.new
	  	i = 1
	  	File.open("top_100_albums.txt").read.each_line do |album|
	  		text = album.split(",")
	  		@info.push({ :rank=> i, :name=> text[0], :year=> text[1].strip })
	  		i += 1
	  	end
	end

  def call(env)
  	request = Rack::Request.new(env)
  	case request.path
  		when "/" then render_form(request)
	  	when "/form" then render_form(request)
	  	when "/list" then render_list(request)
	  	when "/list.css" then render_list_css
	  	when "/shutdown" then exit!
	  	else render_404
    end
  end
  
  def render_404
  	[404, {"Content-Type" => "text/plain"}, ["404, Nothing here!"]]
  end
  
  def render_form(request)
  	response = Rack::Response.new
  	response.write(File.open("form.html", "rb").read)
  	1.upto(100) { |i| response.write("<option value=\"#{i}\">#{i}</option>\n") }
  	response.write(File.open("form2.html", "rb").read)
  	response.finish
  end
  
  def render_list(request)
  	response = Rack::Response.new
  	response.write(File.open("list.html", "rb").read)
  	response.write("<h2>Sorted by #{request['order'].capitalize}</h2>")
  	@info.sort_by { |x| x[request['order'].to_sym] }.each do |album|
  		columns = "<td>#{album[:rank]}</td><td>#{album[:name]}</td><td>#{album[:year]}</td></tr>"
  		if album[:rank] == request['rank'].to_i
  			response_write = "<tr class=\"highlight\">" + columns
  		else
  			response_write = "<tr>" + columns
  		end
  		response.write(response_write)
  	end
  	response.write(File.open("list2.html", "rb").read)
  	response.finish
  end
  
  def render_list_css
  	response = Rack::Response.new
  	response.write(File.open("list.css", "rb").read)
  	response.finish
  end
  
end

Rack::Handler::WEBrick.run Top100Albums.new, :Port => 8080
