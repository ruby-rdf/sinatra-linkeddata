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
    # * Registers Rack::LinkedData::ContentNegotiation
    # * adds helpers
    # * includes RDF and LinkedData
    # * defines `linkeddata_options`, which are passed to the Rack middleware
    #   available as `settings.linkeddata_options` and as options within
    #   the LinkedData Rack middleware.
    #
    # @param  [Sinatra::Base] app
    # @return [void]
    def self.registered(app)
      options = {}
      app.set :linkeddata_options, options
      app.use(Rack::LinkedData::ContentNegotiation, options)
      app.helpers(Sinatra::LinkedData::Helpers)
      app.send(:include, ::RDF)
      app.send(:include, ::LinkedData)
    end
  end
end

Sinatra.register(Sinatra::LinkedData)
