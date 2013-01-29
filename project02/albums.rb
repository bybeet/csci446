require 'rack'

class Top100Albums
  def call(env)
  	request = Rack::Request.new(env)
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
  	albums = File.open("top_100_albums.txt").read
  	i = 1
  	albums.each_line do |album|
  		info = album.split(",")
  		response.write(
  			"<tr>
  			<td>#{i}</td>
  			<td>#{info[0]}</td>
  			<td>#{info[1]}</td>
  			</tr>"
  		)
  		i += 1
  	end
  	response.finish
  end
  
end

Rack::Handler::WEBrick.run Top100Albums.new, :Port => 8080
