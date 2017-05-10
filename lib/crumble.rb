require 'crumble/configuration'
require 'crumble/crumb'
require 'crumble/controller_additions'
require 'crumble/railtie'
require 'crumble/renderer'
require 'crumble/repository'
require 'crumble/version'
require 'crumble/View_helpers'

module Crumble
  module_function def config
    @config ||= Crumble::Configuration.new
  end

  module_function def repository
    @repository ||= Crumble::Repository.new
  end

  module_function def render(options = {})
    Crumble::Renderer.new(options).render
  end
end
