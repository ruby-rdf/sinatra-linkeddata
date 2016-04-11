#!/usr/bin/env ruby -rubygems
# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.version            = File.read('VERSION').chomp
  gem.date               = File.mtime('VERSION').strftime('%Y-%m-%d')

  gem.name               = 'sinatra-linkeddata'
  gem.homepage           = 'http://ruby-rdf.github.com/sinatra-linkeddata'
  gem.license            = 'Unlicense'
  gem.summary            = 'Linked Data content negotiation for Sinatra applications.'
  gem.description        = 'Sinatra extension for Linked Data content negotiation.'
  gem.rubyforge_project  = 'datagraph'

  gem.authors            = ['Arto Bendiken']
  gem.email              = 'public-rdf-ruby@w3.org'

  gem.platform           = Gem::Platform::RUBY
  gem.files              = %w(AUTHORS CREDITS README.md UNLICENSE VERSION) + Dir.glob('lib/**/*.rb')
  gem.bindir             = %q(bin)
  gem.executables        = %w()
  gem.default_executable = gem.executables.first
  gem.require_paths      = %w(lib)
  gem.extensions         = %w()
  gem.test_files         = %w()
  gem.has_rdoc           = false

  gem.required_ruby_version      = '>= 2.0'
  gem.requirements               = []
  gem.add_runtime_dependency     'rack-linkeddata', '~> 2.0.0'
  gem.add_runtime_dependency     'sinatra',         '~> 1.4'

  gem.add_development_dependency 'yard' ,           '~> 0.8'
  gem.add_development_dependency 'rspec',           '~> 3.4'
  gem.add_development_dependency 'rack-test',       '~> 0.6'

  # Rubinius has it's own dependencies
  if RUBY_ENGINE == "rbx" && RUBY_VERSION >= "2.1.0"
    gem.add_development_dependency 'logger'
  end
  gem.post_install_message       = nil
end