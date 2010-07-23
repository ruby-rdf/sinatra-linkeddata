require 'sinatra/base'
require 'rack/linkeddata'

module Sinatra
  ##
  # @see http://www.sinatrarb.com/extensions.html
  module LinkedData
    autoload :VERSION, 'sinatra/linkeddata/version'

    ##
    # Helper methods.
    module Helpers
      # TODO
    end

    ##
    # @param  [Sinatra::Base] app
    # @return [void]
    def self.registered(app)
      app.use(Rack::LinkedData::ContentNegotiation)
      app.helpers(Sinatra::LinkedData::Helpers)
      app.send(:include, ::RDF)
      app.send(:include, ::LinkedData)
    end
  end
end

Sinatra.register(Sinatra::LinkedData)
