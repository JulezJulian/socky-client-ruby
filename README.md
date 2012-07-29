# Socky - client in Ruby

Also important information can be found on our [google group](http://groups.google.com/group/socky-users).

## About this fork
This fork of the socky-client-ruby adds support for receiving Webhooks triggered by my [socky-server-ruby fork](https://github.com/JulezJulian/socky-server-ruby).

## Installation

Addthe following line to your Gemfile and run the bundle install command:
``` bash
gem "socky-client", :git => "https://github.com/JulezJulian/socky-client-ruby.git"
```

## Usage

First require Socky Client:

``` ruby
require 'socky/client'
```

Then createn new Client instance. Parameters required are full address of Socky Server(including app name) and secret of app. In a Rails app this code may go into an own initializerfile.

``` ruby
$socky_client = Socky::Client.new('http://ws.socky.org:3000/http/test_app', 'my_secret')
```

Please note that Ruby Client is HTTP client(not WebSocket) so you need to user http protocol(instead of 'ws') and 'http' namespace(instead of 'websocket'). If you receive EOFError then you probably should double-check address ;)

This instance of Socky Client can trigger events for all users of server. To do so you can use one of methods:

``` ruby
$socky_client.trigger!('my_event', :channel => 'my_channel', :data => 'my data') # Will raise on error
$socky_client.trigger('my_event', :channel => 'my_channel', :data => 'my data') # Will return false on error
$socky_client.trigger_async('my_event', :channel => 'my_channel', :data => 'my data') # Async method
```

Webhook Requests can be validated and parsed by the Socky::Client::Webhook Class:

``` ruby
webhook = Socky::Client::Webhook.new(request, $socky_client)
if webhook.valid?
	# The received request is a valid and correctly signed webhook request. Handle the received events
	puts webhook.data.inspect
	render nothing: true, status: 200
else
	# do nothing
	render nothing: true, status: 403
end
```

request is a Rack::Request Object, so the code above can be used in any Rack Application (including and Rails application). In a Rails application you can put the code above one-to-one in an action if any controller.

## License

(The MIT License)

Copyright (c) 2010 Bernard Potocki

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
