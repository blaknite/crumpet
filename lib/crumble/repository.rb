module Crumble
  class Repository < Array
    def add_crumb(name = nil, url = nil, options = {})
      self << Crumble::Crumb.new(name, url, options)
    end

    def <<(crumb)
      fail ArgumentError, 'crumb must be a Crumble::Crumb' unless crumb.is_a? Crumble::Crumb
      super
    end
  end
end
