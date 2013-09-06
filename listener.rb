require 'sinatra'
require 'controller'

get '/' do 
"<h2>Welcome to ServUby</h2>
Requests are given as:<br>
/browser-command<br>
browsers: firefox, chrome, safari<br>
commands: start, stop and clean<br>" 
end

get '/:command' do
  browser = params[:browser]
  proxy = params[:proxy]
  command = params[:command]
  platform = "Win" if RUBY_PLATFORM.include? "mingw"
  platform = "Mac" if RUBY_PLATFORM.include? "darwin"
  control_object = "#{platform}Controller".constantize.new
  control_object.send("#{browser}_#{command}",proxy)
end

