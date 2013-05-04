# HTTP Intro

## Simple request/response client/server model  

Works as the foundation of data communication on the web, but is used for a lot more.  

* stateless  
* v1.1  

HTTP is the application layer that web technologies run on top.  It acts as the transport layer, but has the ability to do much more.  See [RESTful style of architecture](https://en.wikipedia.org/wiki/Representational_state_transfer).  

## Resource driven  

HTTP gives you a way to interact with resources.  Resources are identified by the URI.  URL is a subset of URI that most people are familiar with.  

Web browser acts as a common client, but certainly not the only one.  Due to it's flexibility, simplicity and feature set, a lot more going on with HTTP than just the web.  

* Data API servers (SalesForce, GitHub)
* Cloud API services (Amazon, Rackspace)

## Proxies & Cache

HTTP was designed to be proxied to help improve or enable communications that couldn't happen otherwise.  

The HTTP response can be cached at many places along the way which saves on server resources and network bandwidth.  Can also be a frustrating problem to solve when you forget. =)

### Potential cache locations  

* Local client browser  
* Network border proxies  
* ISP proxies  
* Server-side reverse proxies  

# Getting our hands dirty (netcat)  

This could all be done with a telnet client on a Windows box as well.  

## Simple web request    

	nc google.com 80  
	HEAD / HTTP/1.0  

* Why did I use version 1.0 instead of 1.1.?  

## HTTP 1.1  

	nc socialgeeks.com 80  
	HEAD / HTTP/1.1 

	nc google.com 80  
	HEAD / HTTP/1.1

* Why did one error and one work?

## HTTP 1.1 proper

	nc socialgeeks.com 80  
	HEAD / HTTP/1.1  
	Host: socialgeeks.com  

* Notice the persistent connection?  

## HTTP 1.1 persistent  

	nc socialgeeks.com 80  
	HEAD / HTTP/1.1  
	Host: socialgeeks.com  

	... response trimmed ...  

	OPTIONS / HTTP/1.1  
	Host: socialgeeks.com  

* Allowing the OPTIONS method does give away information and is disabled on a lot of websites (as opposed to an HTTP API)  

## OPTIONS  

	nc arch-challenges 80  
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
	more search-results  
	grep security search-results  

# HTTP status codes  

[HTTP status codes](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html) are returned in the first line of the HTTP response and can specify a number of things. an applications to give descriptive errors directory through the HTTP protocol.  

* 1xx - informational
* 2xx - success  
* 3xx - redirection 
* 4xx - client error  
* 5xx - server error  

Status codes give you a quick way to see why/where things are going wrong.  

# HTTP Methods

[HTTP methods or verbs](http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html) are specified in the first line of the HTTP request.  

* GET - retrieves a resource  
* HEAD - retrieve HTTP headers  
* POST - create a new subordinate resource to the specified URI  
* PUT - update or create a resource at the specified URI  
* DELETE - delete specified resource  
* TRACE - debugging method, returns what you sent  
* OPTIONS - shows available methods, useful for APIs  
* PATCH - partially update specified resource  

## Safe methods  

The following methods should not create any changes on the server.  This abused all the time by developers using GET to udpate resources.  By virtue of being safe, these methods are also idempotent.  

* HEAD  
* GET  
* OPTIONS  
* TRACE  

## Idempotent methods  

If the HTTP request is replayed with one of these methods, the results should be the same.  

* PUT  
* DELETE  

# HTTP transactions unmasked  

Use paros proxy to browse the web and then go through the requests and responses as look at the different parts of the requests and responses.  The trap tab in paros can be used to catch an outgoing request and edit it prior to delivery.  Use wireshark to show that you can view any http traffic.  

# cURL

## TRACE

How do we know if our request is being changed between us and the webserver? Not perfect and blocked by a lot of sites, but can be a useful debugging tool.  

	curl -X TRACE challenge_server  

## Google search  

	curl http://www.google.com/search?q=kali  

* Why do we get a client not allowed error?  This worked with netcat.
* What is different between this and netcat?

## Google search proper

	curl -A "" http://www.google.com/search?q=kali -0  
	curl -A "" http://www.google.com/search?q=kali

* Now we know that Google discriminates against the User-Agent header

## Google search my way  

	curl -H "User-Agent: Dan Rocks" http://www.google.com/search?q=kali  
	curl -A "curl" http://www.google.com/search?q=kali  

* Google appears to respect my authority, but not the authority of cURL

### Who's authority would they respect?
My browser?  Time to use wireshark to get user-agent on a browser search to Google.  

	curl -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31" http://www.google.com/search?q=kali  

	curl -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31" http://www.google.com/search?q=kali  

## DuckDuckGo!  

	curl -X GET http://duckduckgo.com/?q=kali&format=json  

* What happened, two things that I see?
* Did that command even run right?  

## DuckDuckGo again  

	curl -X GET "http://duckduckgo.com/?q=kali&format=json"  
	curl -X GET http://duckduckgo.com/?q=kali  
	curl -X GET https://duckduckgo.com/?q=kali  

* So they discriminate against us if we don't specify the format on the HTTP version?
* Why does it work on https?  

### Is it a HTTP version?  

	curl -X GET http://duckduckgo.com/?q=kali -0  
	curl -A "" -X GET http://duckduckgo.com/?q=kali  
	
* Nope looks like they are discriminating against the User-Agent
* Why?  

### Proper User-Agent  

	curl -H "User-Agent:Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31" -X GET http://duckduckgo.com/?q=kali  

	curl -H "User-Agent:Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31" -X GET https://duckduckgo.com/?q=kali  

* That's good, they appear to be forcing common User-Agent strings over to https  

### Referer and multiple headers  

	curl -X POST -H "User-Agent:" http://duckduckgo.com/ -d "q=kali linux&format=json"  
	curl -X POST -H "User-Agent:" -H "Referer: Dan" https://duckduckgo.com/ -d "q=kali linux&format=json"  

### Knock it off Google!  

	curl -X POST -H "User-Agent:" -H "Referer: http://google.com/q=duckduckgo"  http://duckduckgo.com/ -d "q=kali linux&format=xml"  

# SGCTF and cURL  
## Register for the leaderboard  

	curl -H "Content-Type: application/json" http://arch_challenges:5000/api/player/create -d '{"name":"viking"}  

* This will return a token that you will use to register flags

## Submit flags to leaderboard  

	curl -H "Content-Type: application/json" http://192.168.10.123:5000/api/flag/capture -d '{"token": "your_random_token_here", "password": "captured_flag"}'  
