require 'crumpet/configuration'
require 'crumpet/crumb'
require 'crumpet/controller_additions'
require 'crumpet/railtie'
require 'crumpet/renderer'
require 'crumpet/repository'
require 'crumpet/version'
require 'crumpet/view_helpers'

module Crumpet
  module_function def config
    @config ||= Crumpet::Configuration.new
  end

  module_function def crumbs
    @crumbs ||= Crumpet::Repository.new
  end

  def self.render(options = {})
    Crumpet::Renderer.new(options).render
  end

  def self.configure
    yield config
  end
end
