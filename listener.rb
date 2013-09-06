require 'sinatra'
require 'C:\Users\Browserstack\Documents\gitrepos\browser_server\win_controller'
require 'C:\Users\Browserstack\Documents\gitrepos\browser_server\mac_controller'

set :bind, '0.0.0.0'

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

