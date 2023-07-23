# Linked Data Content Negotiation for Sinatra Applications

This is a [Sinatra][] extension that provides [Linked Data][] content
negotiation for Sinatra applications.


[![Gem Version](https://badge.fury.io/rb/sinatra-linkeddata.svg)](https://badge.fury.io/rb/sinatra-linkeddata)
[![Build Status](https://github.com/ruby-rdf/sinatra-linkeddata/workflows/CI/badge.svg?branch=develop)](https://github.com/ruby-rdf/sinatra-linkeddata/actions?query=workflow%3ACI)
[![Gitter chat](https://badges.gitter.im/ruby-rdf/rdf.png)](https://gitter.im/ruby-rdf/rdf)

## Features

* Implements [HTTP content negotiation][conneg] for RDF content types using
  the `[Rack::LinkedData][Rack::LinkedData]` middleware.
* Supports all [RDF.rb][] -compatible serialization formats.
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
`[Rack::LinkedData][Rack::LinkedData]` middleware, which implements Linked
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

See the `[Rack::LinkedData][Rack::LinkedData]` documentation for more information on the
operation and details of the content negotiation.

## Documentation

* [Sinatra::LinkedData](https://ruby-rdf.github.io/sinatra-linkeddata/master)

## Dependencies

* [Sinatra](https://rubygems.org/gems/sinatra) (~> 2.0)
* [Rack::LinkedData](https://rubygems.org/gems/rack-linkeddata) (~> 3.1)

## Installation

The recommended installation method is via [RubyGems](https://rubygems.org/).
To install the latest official release of the gem, do:

    % [sudo] gem install sinatra-linkeddata

## Download

To get a local working copy of the development repository, do:

    % git clone git://github.com/ruby-rdf/sinatra-linkeddata.git

Alternatively, you can download the latest development version as a tarball
as follows:

    % wget https://github.com/ruby-rdf/sinatra-linkeddata/tarball/master

## References

* <https://www.w3.org/DesignIssues/LinkedData.html>
* <https://linkeddata.org/docs/how-to-publish>
* <https://linkeddata.org/conneg-303-redirect-code-samples>
* <https://www.w3.org/TR/cooluris/>
* <https://www.w3.org/TR/swbp-vocab-pub/>
* <https://patterns.dataincubator.org/book/publishing-patterns.html>

## Authors

* [Arto Bendiken](https://github.com/artob) - <https://ar.to/>

## License

`Sinatra::LinkedData` is free and unencumbered public domain software. For more
information, see <https://unlicense.org/> or the accompanying UNLICENSE file.

[Sinatra]:          https://www.sinatrarb.com/
[Rack]:             https://rack.github.com/
[RDF.rb]:           https://ruby-rdf.github.io/rdf/
[Rack::LinkedData]: https://rubygems.org/gems/rack-linkeddata/
[Linked Data]:      https://linkeddata.org/
[conneg]:           https://en.wikipedia.org/wiki/Content_negotiation
