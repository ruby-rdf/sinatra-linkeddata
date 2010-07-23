#!/usr/bin/env ruby -rubygems
require 'sinatra'
require 'sinatra/linkeddata'

get '/hello' do
  RDF::Graph.new do |graph|
    graph << [RDF::Node.new, RDF::DC.title, "Hello, world!"]
  end
end
