module Crumpet
  module ViewHelpers
    def render_crumbs(options = {})
      crumbs.render(options)
    end

    def crumbs
      @_crumbs ||= Crumpet::Repository.new
    end
  end
end
