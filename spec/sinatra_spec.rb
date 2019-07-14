$:.unshift "."
require 'spec_helper'
require 'sinatra'

class SPTest < Sinatra::Base
  register Sinatra::LinkedData

  get '/' do
    body "A String"
  end

  get '/graph' do
    settings.linkeddata_options.merge!(:format => (params["fmt"] ? params["fmt"].to_sym : nil))
    body RDF::Graph.new << [RDF::Node('a'), RDF.URI('http://example/b'), "c"]
  end
end

require 'rack/test'

describe Sinatra::LinkedData do
  include ::Rack::Test::Methods

  def app
    SPTest.new
  end

  describe "self.registered" do
    it "sets :linkeddata_options" do
      expect(Sinatra::Application.linkeddata_options).to be_a(Hash)
    end
  end

  context "serializes graphs" do
    context "with format" do
      {
        :ntriples => %r{_:a <http://example/b> "c" \.},
        :ttl => %r{\[\s*<http://example/b> "c"\]}
      }.each do |fmt, expected|
        context fmt do
          it "returns serialization" do
            get '/graph', :fmt => fmt
            expect(last_response.status).to eq 200
            expect(last_response.body).to match(expected)
            expect(RDF::Format.for(fmt).content_type).to include(last_response.content_type)
            expect(last_response.content_length).not_to eq 0
          end
        end
      end
    end
    
    context "with Accept" do
      {
        "application/n-triples" => %r{_:a <http://example/b> "c" \.},
        "application/turtle" => %r{\[\s*<http://example/b> "c"\]}
      }.each do |content_type, expected|
        context content_type do
          it "returns serialization" do
            get '/graph', {}, {"HTTP_ACCEPT" => content_type}
            expect(last_response.status).to eq 200
            expect(last_response.body).to match(expected)
            expect(last_response.content_type).to eq content_type
            expect(last_response.content_length).not_to eq 0
          end
        end
      end
    end
  end
end