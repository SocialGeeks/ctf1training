# HTTP Intro

request/response client/server model  
Works as the foundation of data communication on the web, but is used for a lot more.  
stateless  
v1.1  
HTTP is the application layer that web technologies run on top.  It acts as the transport layer, but has the ability to do much more.  See RESTful style of architecture.  

HTTP gives you a way to interact with resources.  Resources are identified by the URI.  URL is a subset of URI that most people are familiar with.  

Web browser acts as a common client, but certainly not the only one.  A lot more to HTTP than just the web.  

HTTP was designed to be proxied to help improve or enable communications that couldn't happen otherwise.  

Browser caches, border proxies can cache (give demo with TRACE)  

# TCP/IP tools (netcat/telnet)

This could all be done with a telnet client on a Windows box as well.  

## Simple web request    

	nc google.com 80  
	HEAD / HTTP/1.0  

* Why did I do version 1.0 instead of 1.1.?  

## HTTP 1.1  

	nc google.com 80  
	HEAD / HTTP/1.1  

* errors out because of missing Host: header

	nc google.com 80  
	HEAD / HTTP/1.1  
	Host: www.google.com  

* notice the persistent connection?

	OPTIONS / HTTP/1.1
	Host: www.google.com

## OPTIONS  

* Show a server that allows the OPTIONS method  

	nc challenge_server 80  
	OPTIONS / HTTP/1.0  

## Do a google search  

Use a browser to see the syntax.  

	nc google.com 80  
	GET /search?q=kali HTTP/1.0  

## Do a duckduckgo search  

	nc duckduckgo.com 80  
	GET /?q=kali&format=json HTTP/1.0  

* Notice I can specify the format the results are returned in?  Useful for scripting.

## Stash search results for later  

	nc duckduckgo.com 80 > search-results  
	GET /q=ctf&format=json HTTP/1.0  

# HTTP status codes  

Allows an applications to give descriptive errors directory through the HTTP protocol.  

* 2xx - success  
* 3xx - redirect  
* 4xx - error  
* 5xx - server error  

# HTTP Methods

* GET
* HEAD
* POST
* PUT
* DELETE
* TRACE
* OPTIONS
* CONNECT
* PATCH

Safe methods (part of the nature being safe makes them idempotent)  

* HEAD
* GET
* OPTIONS
* TRACE

Idempotent methods  

* PUT
* DELETE

# curl

curl http://www.google.com/search?q=kali  
## Gives a client not allowed error, good chance to probe the crowd about figuring out how to figure out why?
## What is different between this and netcat/telnet?
curl -A "" http://www.google.com/search?q=kali -0
## Now we know that Google discriminates against the User-agent header
curl -H "User-agent:Dan Rocks!" http://www.google.com/search?q=kali -0
## And they certainly don't respect my authority!
## Who's authority would they respect?  My browser?  More wireshark to get user-agent on a browser search to Google
curl -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31" http://www.google.com/search?q=kali -0
curl -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31" http://google.com/search?q=kali -0
curl -X GET http://duckduckgo.com/?q=kali&format=json
## What happened, two things that I see
curl -X GET "http://duckduckgo.com/?q=kali&format=json"
curl -X GET http://duckduckgo.com/?q=kali
curl -X GET https://duckduckgo.com/?q=kali
## So they discriminate against us if we don't specify the format on the HTTP version?
## Is it a HTTP version?
curl -X GET http://duckduckgo.com/?q=kali -0
curl -A "" -X GET http://duckduckgo.com/?q=kali -0
curl -A "" -X GET http://duckduckgo.com/?q=kali
## Another way to manipulate the headers with curl
curl -H "User-Agent:" -X GET http://duckduckgo.com/?q=kali
## Or we could pass in a valid user-agent as before.
curl -H "User-Agent:Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31" -X GET http://duckduckgo.com/?q=kali
curl -H "User-Agent:Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31" -X GET https://duckduckgo.com/?q=kali
## That is good, they appear to be forcing common user-agent strings over to https

curl -X POST -H "User-Agent:" http://duckduckgo.com/ -d "q=kali linux&format=json"
curl -X POST -H "User-Agent:" -H "Referer: Dan" https://duckduckgo.com/ -d "q=kali linux&format=json"
curl -X POST -H "User-Agent:" -H "Referer: http://google.com/q=duckduckgo"  http://duckduckgo.com/ -d "q=kali linux&format=xml"

## For the leaderboard you will need to pass the data in json (common with API's)
curl -H "Content-Type:application/json" http://localhost:5000/api/player/create -d '{"name":"sgviking"}

# proxy

Use paros proxy to browse the web and then go through the requests and responses as a way to introduce them to a more headers.  

Pop open wireshark to show that the HTTP traffic can be collected.  

# HTTP headers

	Content-Type: application/json  
	Host:  
	Referer:  
	User-Agent:  

# HTTP request

wireshark/paros  

# HTTP response

wireshark/paros  