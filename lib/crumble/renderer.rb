module Crumble
  class Renderer
    include ActionView::Helpers::UrlHelper
    include ERB::Util

    attr_reader :options

    def initialize(options = {})
      @options = options
    end

    def render
      repository.map{ |crumb| render_crumb(crumb) }.join(option_or_default(:separator)).html_safe
    end

    private

    def repository
      Crumble.repository
    end

    def render_crumb(crumb)
      case option_or_default(:format)
      when :html
        render_html(crumb)
      when :xml
        render_xml(crumb)
      when :json
        render_json(crumb)
      else
        raise NotImplementedError, "unsupported format: #{option_or_default(:format)}"
      end
    end

    def render_html(crumb)
      name            = render_name(crumb)
      link_options    = build_link_options(crumb)
      wrapper_options = build_wrapper_options(crumb)

      output = link?(crumb) ? link_to(name, crumb.url, link_options) : content_tag(:span, name, link_options)
      output = content_tag(crumb.wrap_with, output, wrapper_options) if crumb.wrap?
      output
    end

    def render_name(crumb)
      name = crumb.name
      name = name.truncate(crumb.truncate) if crumb.truncate?
      name = h(name) if crumb.escape?
      name.html_safe
    end

    def build_link_options(crumb)
      link_options = options.fetch(:link_options, {}).merge(crumb.link_options)

      link_options[:class] = Array(link_options.fetch(:class, []))
      link_options[:class] << option_or_default(:default_crumb_class).presence
      link_options[:class] << option_or_default(:first_crumb_class).presence if crumb == repository.first
      link_options[:class] << option_or_default(:last_crumb_class).presence if crumb == repository.last
      link_options[:class].compact!
      link_options[:class].uniq!
      link_options.delete(:class) if link_options[:class].blank?

      link_options
    end

    def build_wrapper_options(crumb)
      options.fetch(:wrapper_options, {}).merge(crumb.wrapper_options)
    end

    def link?(crumb)
      option_or_default(:link) && crumb.link? && ( option_or_default(:link_last_crumb) || crumb != repository.last )
    end

    def option_or_default(option)
      options.fetch(option, Crumble.config.send(option.to_sym)).clone
    end
  end
end
