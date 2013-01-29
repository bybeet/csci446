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
  	
  	response.write(request["rank"])
  	response.finish
  end
  
end

Rack::Handler::WEBrick.run Top100Albums.new, :Port => 8080
