module Crumpet
  class Repository < Array
    def add_crumb(name = nil, url = nil, options = {})
      self << Crumpet::Crumb.new(name, url, options)
    end

    def <<(crumb)
      fail ArgumentError, 'crumb must be a Crumpet::Crumb' unless crumb.is_a? Crumpet::Crumb
      super
    end
  end
end
