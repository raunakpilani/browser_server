
class MacController

  def initialize
    @proxy_host = "127.0.0.1"
    @proxy_port = 3128
    @firefox_path = "/Applications/firefox.app/Contents/MacOS/firefox"
    @firefox_user = "/Users/raunakpilani/Library/Application\\ Support/Firefox/Profiles/*.Empty"
    @chrome_exec = "/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome"
    @chrome_user = "/Users/raunakpilani/Library/Application Support/Google/Chrome-empty"
    @safari_profile = "/USers/raunakpilani/Library/Safari"
  end

  def firefox_start(url, proxy = nil)
    if proxy == "true"
      spawn("#{@firefox_path} -CreateProfile Empty && path=`ls -d #{@firefox_user}` && echo 'user_pref(\"    network.proxy.http\", \"#{@proxy_host}\");\\nuser_pref(\"network.proxy.http_port\", #{@proxy_port});\\nuser_pre    f(\"network.proxy.type\", 1);' >> $path/prefs.js && #{@firefox_path} -P Empty #{url}")
    else
      spawn("\"#{@firefox_path}\" -CreateProfile Empty && \"#{@firefox_path}\" -P Empty #{url}")
    end

    proxy_statement = proxy ? "with proxy #{@proxy_host}:#{@proxy_port}" : ""
    "Started Firefox #{proxy_statement}"
  end

  def chrome_start(url, proxy = nil)
    if proxy == "true"
      spawn("#{@chrome_exec} --enable-udd-profiles --user-data-dir=\"#{@chrome_user}\" --profile-directory=\"Empty\" --proxy-server=\"#{@proxy_host}:#{@proxy_port}\" #{url}")
    else
      spawn("#{@chrome_exec} --enable-udd-profiles --user-data-dir=\"#{@chrome_user}\" --profile-dire    ctory=\"Empty\" #{url}")
    end

    proxy_statement = proxy ? "with proxy #{@proxy_host}:#{@proxy_port}" : ""
    "Started Chrome #{proxy_statement}"
  end

  def safari_start(url, proxy = nil)
    if proxy == "true"
      spawn("sudo /usr/sbin/networksetup -setwebproxy \"wi-fi\" #{@proxy_host} #{@proxy_port} && sudo /usr/sbin/n    etworksetup -setwebproxystate \"wi-fi\" on && open -a /Applications/Safari.app #{url}")
    else
      spawn("open -a /Applications/Safari.app #{url}")
    end

    proxy_statement = proxy ? "with proxy #{@proxy_host}:#{@proxy_port}" : ""
    "Started Safari #{proxy_statement}"
  end

  def firefox_stop(url, proxy = nil)
    spawn("pkill firefox")
    "Stopped Firefox"
  end

  def chrome_stop(url, proxy = nil)
    spawn("pkill Google\ Chrome")
    "Stopped Chrome"
  end

  def safari_stop(url, proxy = nil)
    spawn("sudo /usr/sbin/networksetup -setwebproxystate \"wi-fi\" off &&  pkill Safari")
  end

  def firefox_clean(url, proxy = nil)
    spawn("rm -rf #{@firefox_user}")
    "Cleaned Firefox"
  end

  def chrome_clean(url, proxy = nil)
    spawn("rm -rf #{@chrome_user}")
    "Cleaned Chrome"
  end

  def safari_clean(url, proxy = nil)
    spawn ("rm -rf #{@safari_user}/*.plist #{@safari_user}/*.sk" )
    "Cleaned Safari"
  end

end

