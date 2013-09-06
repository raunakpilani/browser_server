
class WinController

  def initialize
    @proxy_host = "127.0.0.1"
    @proxy_port = 3128
    @firefox_path = "C:\\Program Files (x86)\\Mozilla Firefox\\firefox.exe"
    @firefox_local_appdata = "%LOCALAPPDATA%\\Mozilla\\Firefox\\Profiles\\*.Empty"
    @firefox_roaming_appdata = "%APPDATA%\\Mozilla\\Firefox\\Profiles\\*.Empty"
    @chrome_user = "%LOCALAPPDATA%\\Google\\Chrome\\User Data"
    @inet_registry = "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings"
    @safari_local_appdata = "%LOCALAPPDATA%\\Apple Computer\\Safari"
    @safari_roaming_appdata = "%APPDATA%\\Apple Computer\\Safari"
    @safari_pref_appdata = "%APPDATA%\\Apple Computer\\Preferences"
  end

  def firefox_start(url, proxy = nil)
    puts "url=#{url}="
    if proxy == "true"
    puts "proxy=#{proxy}="
      spawn("\"#{@firefox_path}\" -CreateProfile Empty && for /D %f in (\"#{@firefox_local_appdata}\") do echo 'user_pref(\"network.proxy.http\", \"#{@proxy_host}\");\\nuser_pref(\"network.proxy.http_port\", #{@proxy_port});\\nuser_pref(\"network.proxy.type\", 1);' >> %f/prefs.js && for /D %f in (\"#{@firefox_roaming_appdata}\") do echo 'user_pref(\"network.proxy.http\", \"#{@proxy_host}\");\\nuser_pref(\"network.proxy.http_port\", #{@proxy_port});\\nuser_pref(\"network.proxy.type\", 1);' >> %f/prefs.js && \"#{@firefox_path}\" -P Empty #{url}")
    else
      spawn("\"#{@firefox_path}\" -CreateProfile Empty && \"#{@firefox_path}\" -P Empty #{url}")
    end

    proxy_statement = proxy ? "with proxy #{@proxy_host}:#{@proxy_port}" : ""
    "Started Firefox #{proxy_statement}"
  end

  def chrome_start(url, proxy = nil)
    if proxy == "true"
      spawn("start chrome --enable-udd-profiles --user-data-dir=\"#{@chrome_user}\" --profile-directory=\"Empty\" --proxy-server=\"#{@proxy_host}:#{@proxy_port}\" #{url}")
    else
      spawn("start chrome --enable-udd-profiles --user-data-dir=\"#{@chrome_user}\" --profile-directory=\"Empty\" #{url}")
    end

    proxy_statement = proxy ? "with proxy #{@proxy_host}:#{@proxy_port}" : ""
    "Started Chrome #{proxy_statement}"
  end

  def safari_start(url, proxy = nil)
    if proxy == "true"
      spawn("reg add \"#{@inet_registry}\" /v ProxyEnable /t REG_DWORD /d 1 /f && reg add \"#{@inet_registry}\" /v ProxyServer /t REG_SZ /d #{@proxy_host}:#{@proxy_port} /f && start safari #{url}")
    else
      spawn("start safari #{url}")
    end

    proxy_statement = proxy ? "with proxy #{@proxy_host}:#{@proxy_port}" : ""
    "Started Safari #{proxy_statement}"
  end

  def ie_start(url, proxy = nil)
    if proxy == "true"
      spawn("reg add \"#{@inet_registry}\" /v ProxyEnable /t REG_DWORD /d 1 /f && reg add \"#{@inet_registry}\" /v ProxyServer /t REG_SZ /d #{@proxy_host}:#{@proxy_port} /f && start iexplore #{url}")
    else
      spawn("start iexplore #{url}")
    end

    proxy_statement = proxy ? "with proxy #{@proxy_host}:#{@proxy_port}" : ""
    "Started IE #{proxy_statement}"
  end

  def firefox_stop(url, proxy = nil)
    spawn("taskkill /f /im firefox.exe")
    "Stopped Firefox"
  end

  def chrome_stop(url, proxy = nil)
    spawn("taskkill /F /IM chrome.exe")
    "Stopped Chrome"
  end

  def safari_stop(url, proxy = nil)
    spawn("taskkill /f /im safari.exe && reg add \"#{@inet_registry}\" /v ProxyEnable /t REG_DWORD /d 0 /f ")
  end

  def ie_stop(url = nil, proxy = nil)
    spawn("reg add \"#{@inet_registry}\" /v ProxyEnable /t REG_DWORD /d 0 /f && taskkill /f /im iexplore.exe")
  end

  def firefox_clean(url, proxy = nil)
    spawn("for /D %f in (\"#{@firefox_local_appdata}\") do rmdir /s /q \"%f\" && for /D %f in (\"#{@firefox_roaming_appdata}\") do rmdir /s /q \"%f\"")
    "Cleaned Firefox"
  end

  def chrome_clean(url, proxy = nil)
    spawn("rmdir /s /q \"#{@chrome_user}\\Empty\"")
    "Cleaned Chrome"
  end

  def safari_clean(url, proxy = nil)
    spawn ("rmdir /s /q \"#{@safari_local_appdata}\" && rmdir /s /q \"#{@safari_roaming_appdata}\"&& rmdir /s /q \"#{@safari_pref_appdata}\"" )
    "Cleaned Safari"
  end

  def ie_clean(url, proxy = nil)
    spawn ("RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 255")
    spawn ("RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 4351")
    "Cleaned IE"
  end

end

