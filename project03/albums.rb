require 'rack'
require 'sqlite3'

class Top100Albums
	
	def initialize
		@info = Array.new
	  	i = 1
	  	File.open("top_100_albums.txt").read.each_line do |album|
	  		text = album.split(",")
	  		@info.push({ :rank=> i, :name=> text[0], :year=> text[1].strip })
	  		i += 1
	  	end
      #@albums = SQLite3::Database.new("albums.sqlite3.db")
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
  	response.write(ERB.new(File.read("form.erb")).result(binding))
  	response.finish
  end
  
  def render_list(request)
  	response = Rack::Response.new
  	response.write(ERB.new(File.read("album_output.erb")).result(binding))
  	response.finish
  end
  
  def render_list_css
  	response = Rack::Response.new
  	response.write(File.open("list.css", "rb").read)
  	response.finish
  end
  
end

Rack::Handler::WEBrick.run Top100Albums.new, :Port => 8080
