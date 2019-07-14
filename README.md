# Linked Data Content Negotiation for Sinatra Applications

This is a [Sinatra][] extension that provides [Linked Data][] content
negotiation for Sinatra applications.

* <http://github.com/datagraph/sinatra-linkeddata>

[![Gem Version](https://badge.fury.io/rb/sinatra-linkeddata.svg)](http://badge.fury.io/rb/sinatra-linkeddata)
[![Build Status](https://travis-ci.org/ruby-rdf/sinatra-linkeddata.svg?branch=master)](http://travis-ci.org/ruby-rdf/sinatra-linkeddata)

## Features

* Implements [HTTP content negotiation][conneg] for RDF content types using
  the [`Rack::LinkedData`][Rack::LinkedData] middleware.
* Supports all [RDF.rb][]-compatible serialization formats.
* Supports both classic and modular Sinatra applications.

## Examples

### Adding Linked Data content negotiation to a classic Sinatra application

```ruby
#!/usr/bin/env ruby -rubygems
require 'sinatra'
require 'sinatra/linkeddata'

get '/hello' do
  RDF::Graph.new do |graph|
    graph << [RDF::Node.new, RDF::DC.title, "Hello, world!"]
  end
end
```

### Adding Linked Data content negotiation to a modular Sinatra application

```ruby
#!/usr/bin/env ruby -rubygems
require 'sinatra/base'
require 'sinatra/linkeddata'

module My
  class Application < Sinatra::Base
    register Sinatra::LinkedData

    get '/hello' do
      RDF::Graph.new do |graph|
        graph << [RDF::Node.new, RDF::DC.title, "Hello, world!"]
      end
    end
  end
end

My::Application.run! :host => '127.0.0.1', :port => 4567
```

### Adding Linked Data content negotiation to a Rackup application

```ruby
#!/usr/bin/env rackup
require 'sinatra/base'
require 'sinatra/linkeddata'

module My
  class Application < Sinatra::Base
    register Sinatra::LinkedData

    get '/hello' do
      RDF::Graph.new do |graph|
        graph << [RDF::Node.new, RDF::DC.title, "Hello, world!"]
      end
    end
  end
end

run My::Application
```

### Testing Linked Data content negotiation using `rackup` and `curl`

    $ rackup doc/examples/config.ru
    
    $ curl -iH "Accept: application/n-triples" http://localhost:9292/hello
    $ curl -iH "Accept: application/turtle" http://localhost:9292/hello
    $ curl -iH "Accept: application/rdf+xml" http://localhost:9292/hello
    $ curl -iH "Accept: application/json" http://localhost:9292/hello
    $ curl -iH "Accept: application/trix" http://localhost:9292/hello
    $ curl -iH "Accept: */*" http://localhost:9292/hello

## Description

`Sinatra::LinkedData` is a thin Sinatra-specific wrapper around the
[`Rack::LinkedData`][Rack::LinkedData] middleware, which implements Linked
Data content negotiation for Rack applications.

At the moment the Sinatra extension simply corresponds
to doing the following manually in a Sinatra application:

```ruby
require 'rack/linkeddata'

module My
  class Application < Sinatra::Base
    use     Rack::LinkedData::ContentNegotiation
    helpers Sinatra::LinkedData::Helpers
    include RDF
    include LinkedData
  end
end
```

See the `Rack::LinkedData` documentation for more information on the
operation and details of the content negotiation.

## Documentation

* [Sinatra::LinkedData](https://www.rubydoc.info/github/ruby-rdf/sinatra-linkeddata/master)

## Dependencies

* [Sinatra](http://rubygems.org/gems/sinatra) (~> 2.0)
* [Rack::LinkedData](http://rubygems.org/gems/rack-linkeddata) (~> 3.0)

## Installation

The recommended installation method is via [RubyGems](http://rubygems.org/).
To install the latest official release of the gem, do:

    % [sudo] gem install sinatra-linkeddata

## Download

To get a local working copy of the development repository, do:

    % git clone git://github.com/ruby-rdf/sinatra-linkeddata.git

Alternatively, you can download the latest development version as a tarball
as follows:

    % wget http://github.com/ruby-rdf/sinatra-linkeddata/tarball/master

## References

* <http://www.w3.org/DesignIssues/LinkedData.html>
* <http://linkeddata.org/docs/how-to-publish>
* <http://linkeddata.org/conneg-303-redirect-code-samples>
* <http://www.w3.org/TR/cooluris/>
* <http://www.w3.org/TR/swbp-vocab-pub/>
* <http://patterns.dataincubator.org/book/publishing-patterns.html>

## Authors

* [Arto Bendiken](http://github.com/bendiken) - <http://ar.to/>

## License

`Sinatra::LinkedData` is free and unencumbered public domain software. For more
information, see <http://unlicense.org/> or the accompanying UNLICENSE file.

[Sinatra]:          http://www.sinatrarb.com/
[Rack]:             http://rack.github.com/
[RDF.rb]:           http://ruby-rdf.github.com/rdf/
[Rack::LinkedData]: http://datagraph.rubyforge.org/rack-linkeddata/
[Linked Data]:      http://linkeddata.org/
[conneg]:           http://en.wikipedia.org/wiki/Content_negotiation
