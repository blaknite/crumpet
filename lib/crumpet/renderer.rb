module Crumpet
  class Renderer
    include ActionView::Helpers::UrlHelper
    include ERB::Util

    attr_reader :crumbs, :options

    def self.render(crumbs, options = {})
      new(crumbs, options).render
    end

    def initialize(crumbs, options = {})
      @crumbs  = crumbs
      @options = options
    end

    def render
      return '' if crumbs.empty? && !option_or_default(:render_when_blank)

      case option_or_default(:format)
      when :html
        output = crumbs.map{ |crumb| render_html(crumb) }.join(option_or_default(:separator)).html_safe
        output = content_tag(option_or_default(:container).to_sym, output, build_container_options) if option_or_default(:container).present?
        output
      when :xml
        output = crumbs.map{ |crumb| render_xml(crumb) }.join
        output = content_tag(:crumbs, output)
        output
      when :json
        crumbs.map{ |crumb| render_json(crumb) }.to_json
      else
        raise NotImplementedError, "unsupported format: #{option_or_default(:format)}"
      end
    end

    private

    def render_html(crumb)
      name            = render_name(crumb)
      item_options    = build_html_options(crumb)
      wrapper_options = build_wrapper_options(crumb)

      output = link?(crumb) ? link_to(name, crumb.url, item_options) : content_tag(:span, name, item_options)
      output = content_tag(crumb_option_or_default(crumb, :wrapper), output, wrapper_options) if wrap?(crumb)
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
      name = name.truncate(crumb_option_or_default(crumb, :truncate)) if truncate?(crumb)
      name = h(name) if escape?(crumb)
      name.html_safe
    end

    def render_container(content)
      content_tag(option_or_default(:container).to_sym, content, build_container_options)
    end

    def build_html_options(crumb)
      item_options = options.fetch(:item_options, {}).merge(crumb.item_options)

      item_options[:class] = Array(item_options[:class])
      item_options[:class] << option_or_default(:default_crumb_class).presence
      item_options[:class] << option_or_default(:first_crumb_class).presence if crumb == crumbs.first
      item_options[:class] << option_or_default(:last_crumb_class).presence if crumb == crumbs.last
      item_options[:class].compact!
      item_options[:class].uniq!
      item_options.delete(:class) if item_options[:class].blank?

      item_options
    end

    def build_item_options(crumb)
      options.fetch(:item_options, {}).merge(crumb.item_options)
    end

    def build_wrapper_options(crumb)
      wrapper_options = options.fetch(:wrapper_options, {}).merge(crumb.wrapper_options)

      wrapper_options[:class] = Array(wrapper_options[:class])
      wrapper_options[:class] << option_or_default(:default_wrapper_class).presence
      wrapper_options[:class].compact!
      wrapper_options[:class].uniq!
      wrapper_options.delete(:class) if wrapper_options[:class].blank?

      wrapper_options
    end

    def build_container_options
      container_options = options.fetch(:container_options, {})

      container_options[:class] = Array(container_options[:class])
      container_options[:class] << option_or_default(:default_container_class).presence
      container_options[:class].compact!
      container_options[:class].uniq!
      container_options.delete(:class) if container_options[:class].blank?

      container_options
    end

    def link?(crumb)
      crumb.url.present? && ( crumb_option_or_default(crumb, :link) && ( option_or_default(:link_last_crumb) || crumb != crumbs.last ) )
    end

    def truncate?(crumb)
      crumb_option_or_default(crumb, :truncate)
    end

    def wrap?(crumb)
      crumb_option_or_default(crumb, :wrapper).present?
    end

    def escape?(crumb)
      crumb_option_or_default(crumb, :escape).present?
    end

    def option_or_default(option)
      options.fetch(option, Crumpet.config.send(option.to_sym))
    end

    def crumb_option_or_default(crumb, option)
      crumb.options.fetch(option, option_or_default(option))
    end
  end
end
