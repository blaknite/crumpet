module Crumpet
  class Repository < Array
    def render(options = {})
      Crumpet::Renderer.render(self, options)
    end

    def add_crumb(*args)
      self << Crumpet::Crumb.new(*args)
    end

    def <<(crumb)
      fail ArgumentError, 'crumb must be a Crumpet::Crumb' unless crumb.is_a? Crumpet::Crumb
      super
    end
  end
end
