module Crumpet
  class Renderer
    include ActionView::Helpers::UrlHelper
    include ERB::Util

    attr_reader :options

    def initialize(options = {})
      @options = options
    end

    def render
      output = render_crumbs
      output = render_container(output) if option_or_default(:container).present?
      output
    end

    private

    def repository
      Crumpet.repository
    end

    def render_crumbs
      case option_or_default(:format)
      when :html
        repository.map{ |crumb| render_html(crumb) }.join(option_or_default(:separator)).html_safe
      when :xml
        repository.map{ |crumb| render_xml(crumb) }.join
      when :json
        repository.map{ |crumb| render_json(crumb) }
      else
        raise NotImplementedError, "unsupported format: #{option_or_default(:format)}"
      end
    end

    def render_html(crumb)
      name            = render_name(crumb)
      item_options    = build_html_options(crumb)
      wrapper_options = build_wrapper_options(crumb)

      output = link?(crumb) ? link_to(name, crumb.url, item_options) : content_tag(:span, name, item_options)
      output = content_tag(crumb.wrap_with, output, wrapper_options) if crumb.wrap?
      output
    end

    def render_xml(crumb)
      item_options = build_item_options(crumb)
      item_options = item_options.merge(href: crumb.url) if link?(crumb)

      content_tag(:crumb, render_name(crumb), item_options)
    end

    def render_json(crumb)
      output = build_item_options(crumb).merge(name: render_name(crumb))
      output = output.merge(href: crumb.url) if link?(crumb)
      output
    end

    def render_name(crumb)
      name = crumb.name
      name = name.truncate(crumb.truncate) if crumb.truncate?
      name = h(name) if crumb.escape?
      name.html_safe
    end

    def render_container(content)
      content_tag(option_or_default(:container).to_sym, content, class: option_or_default(:container_class).presence)
    end

    def build_html_options(crumb)
      item_options = options.fetch(:item_options, {}).merge(crumb.item_options)

      item_options[:class] = Array(item_options.fetch(:class, []))
      item_options[:class] << option_or_default(:default_crumb_class).presence
      item_options[:class] << option_or_default(:first_crumb_class).presence if crumb == repository.first
      item_options[:class] << option_or_default(:last_crumb_class).presence if crumb == repository.last
      item_options[:class].compact!
      item_options[:class].uniq!
      item_options.delete(:class) if item_options[:class].blank?

      item_options
    end

    def build_item_options(crumb)
      options.fetch(:item_options, {}).merge(crumb.item_options)
    end

    def build_wrapper_options(crumb)
      options.fetch(:wrapper_options, {}).merge(crumb.wrapper_options)
    end

    def link?(crumb)
      option_or_default(:link) && crumb.link? && ( option_or_default(:link_last_crumb) || crumb != repository.last )
    end

    def option_or_default(option)
      options.fetch(option, Crumpet.config.send(option.to_sym)).clone
    end
  end
end
