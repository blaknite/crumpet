module Crumpet
  class Crumb
    attr_reader :name, :url, :options

    def initialize(name, *args)
      @options = args.extract_options!
      @name = name
      @url = args.first
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
      wrapper.present?
    end

    def wrapper
      option_or_default(:wrapper)
    end

    def item_options
      options.fetch(:item_options, {})
    end

    def wrapper_options
      options.fetch(:wrapper_options, {})
    end

    private

    def option_or_default(option)
      options.fetch(option, Crumpet.config.send(option.to_sym).clone)
    end
  end
end
