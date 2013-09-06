Browser Server

run using:
>ruby listener.rb

requests are made as follows:
127.0.0.1:4567/<command>?browser=<browser>&url="<url>"

where:
<command> - start, stop, clean
<browser> - firefox, chrome, ie (only in windows), safari
<url> - must be preceded with http/https where needed

for proxy setting to 127.0.0.1:3128 use:
127.0.0.1:4567/<command>?browser=<browser>&url="<url>"&proxy=true 
