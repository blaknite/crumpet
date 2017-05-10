module Crumble
  module ViewHelpers
    def render_crumbs(options = {})
      Crumble.render(options)
    end

    def crumbs
      Crumble.repository
    end
  end
end
