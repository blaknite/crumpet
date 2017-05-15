module Crumpet
  module ViewHelpers
    def render_crumbs(options = {})
      Crumpet.render(options)
    end

    def crumbs
      Crumpet.crumbs
    end
  end
end
