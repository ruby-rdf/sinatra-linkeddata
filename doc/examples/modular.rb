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
