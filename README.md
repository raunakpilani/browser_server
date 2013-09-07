Browser Server

run using:
>ruby listener.rb

requests are made as follows: 

http://127.0.0.1:4567/[command]?browser=[browser]&url="[url]"

for proxy setting to 127.0.0.1:3128 use: 

http://127.0.0.1:4567/[command]?browser=[browser]&url="[url]"&proxy=true

>where:

>[command] - start, stop, clean

>[browser] - firefox, chrome, ie (only in windows), safari

>[url] - must be preceded with http/https where needed

for proxy setting to 127.0.0.1:3128 use: http://127.0.0.1:4567/[command]?browser=[browser]&url="[url]"&proxy=true 

also in the repo is auto-it script to keep server alive, this can be compiled to exe and then added to start-up
