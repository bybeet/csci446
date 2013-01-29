require 'rack'

class Top100Albums
  def call(env)
  	request = Rack::Request.new(env)
  	albums = File.open("top_100_albums.txt").read
  	@info = Array.new
  	i = 1
  	albums.each_line do |album|
  		text = album.split(",")
  		@info.push(["rank"=> i, "title"=> text[0], "year"=> text[1].strip])
  		i += 1
  	end
  	puts @info[0]
  	case request.path
  		when "/" then render_form(request)
	  	when "/form" then render_form(request)
	  	when "/list" then render_list(request)
	  	when "/shutdown" then exit!
	  	else render_404
    end
  end
  
  def render_404
  	[404, {"Content-Type" => "text/plain"}, ["404, Nothing here!"]]
  end
  
  def render_form(request)
  	response = Rack::Response.new
  	File.open("form.html", "rb") { |form| response.write(form.read) }
  	1.upto(100) { |i| response.write("<option value=\"#{i}\">#{i}</option>\n") }
  	File.open("form2.html", "rb") { |form| response.write(form.read) }
  	response.finish
  end
  
  def render_list(request)
  	response = Rack::Response.new
  	File.open("list.html", "rb") { |list| response.write(list.read) }
  	response.write("<h2>Sorted by #{request['order'].capitalize}</h2>")
  	@info.each do |album, index|
  		if album['rank'] == request['rank']
  			response_write = "<tr class=\"highlight\">
  			<td>#{album['rank']}</td>
  			<td>#{album['title']}</td>
  			<td>#{album['year']}</td>
  			</tr>"
  		else
  			response_write = "<tr>
  			<td>#{album['rank']}</td>
  			<td>#{album['title']}</td>
  			<td>#{album['year']}</td>
  			</tr>"
  		end
  		response.write(response_write)
  	end
  	puts request['rank']
  	response.finish
  end
  
end

Rack::Handler::WEBrick.run Top100Albums.new, :Port => 8080
