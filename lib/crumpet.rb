require 'crumpet/configuration'
require 'crumpet/crumb'
require 'crumpet/controller_additions'
require 'crumpet/railtie'
require 'crumpet/renderer'
require 'crumpet/repository'
require 'crumpet/version'
require 'crumpet/View_helpers'

module Crumpet
  module_function def config
    @config ||= Crumpet::Configuration.new
  end

  module_function def repository
    @repository ||= Crumpet::Repository.new
  end

  module_function def render(options = {})
    Crumpet::Renderer.new(options).render
  end
end
