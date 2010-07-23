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
