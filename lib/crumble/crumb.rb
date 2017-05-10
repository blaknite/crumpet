module Crumble
  class Crumb
    attr_reader :name, :url, :options

    def initialize(name, url, options = {})
      @name = name
      @url = url
      @options = options
    end

    def link?
      url.present? && option_or_default(:link).present?
    end

    def escape?
      option_or_default(:escape)
    end

    def truncate?
      truncate.present?
    end

    def truncate
      option_or_default(:truncate)
    end

    def wrap?
      wrap_with.present?
    end

    def wrap_with
      option_or_default(:wrap_with)
    end

    def only
      Array(options.fetch(:only, []))
    end

    def except
      Array(options.fetch(:except, []))
    end

    def item_options
      options.fetch(:item_options, {})
    end

    def wrapper_options
      options.fetch(:wrapper_options, {})
    end

    private

    def option_or_default(option)
      options.fetch(option, Crumble.config.send(option.to_sym).clone)
    end
  end
end
