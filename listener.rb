require 'sinatra'
require 'pathname'
require File.dirname(Pathname.new(__FILE__).realpath.to_s).to_s + '/win_controller' 
require File.dirname(Pathname.new(__FILE__).realpath.to_s).to_s + '/mac_controller' 

set :bind, '0.0.0.0'

get '/' do 
"<h2>Welcome to the Browser Server</h2>
Requests are given as:<br>
/[command]?browser=[browser]&proxy=true&url=[\"http://[url]\"]<br>
browsers: firefox, chrome, safari or ie (only for windows)<br>
commands: start, stop and clean<br>
proxy = true sets proxy as 127.0.0.1:3128, leave option out for no proxy<br>" 
end

get '/:command' do
  browser = params[:browser]
  proxy = params[:proxy]
  command = params[:command]
  url = params[:url]
  url = "about:blank" unless url
  control_object = WinController.new if RUBY_PLATFORM.include? "mingw"
  control_object = MacController.new if RUBY_PLATFORM.include? "darwin"
  begin
  control_object.send("#{browser}_#{command}", url, proxy)
  rescue NoMethodError => msg
    puts msg
  end
end

