$:.unshift "."
require 'spec_helper'
require 'rack/test'
require 'sinatra'

describe Sinatra::LinkedData do
  include ::Rack::Test::Methods

  def app
    Sinatra::Application
  end

  get '/' do
    body "A String"
  end

  get '/graph' do
    settings.linkeddata_options.merge!(:format => (params["fmt"] ? params["fmt"].to_sym : nil))
    body RDF::Graph.new << [RDF::Node('a'), RDF::URI('b'), "c"]
  end

  describe "self.registered" do
    it "sets :linkeddata_options" do
      Sinatra::Application.linkeddata_options.should be_a(Hash)
    end
  end

  context "serializes graphs" do
    context "with format" do
      {
        :ntriples => /_:a <b> "c" \./,
        :ttl => /[ <b> "c"]/
      }.each do |fmt, expected|
        context fmt do
          it "returns serialization" do
            get '/graph', :fmt => fmt
            last_response.status.should == 200
            last_response.body.should match(expected)
            last_response.content_type.should == RDF::Format.for(fmt).content_type.first
            last_response.content_length.should_not == 0
          end
        end
      end
    end
    
    context "with Accept" do
      {
        "text/plain" => /_:a <b> "c" \./,
        "text/turtle" => /[ <b> "c"]/
      }.each do |content_types, expected|
        context content_types do
          it "returns serialization" do
            get '/graph', {}, {"HTTP_ACCEPT" => content_types}
            last_response.status.should == 200
            last_response.body.should match(expected)
            last_response.content_type.should == content_types
            last_response.content_length.should_not == 0
          end
        end
      end
    end
  end
end