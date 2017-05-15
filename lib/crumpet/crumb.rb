module Crumpet
  class Crumb
    attr_reader :name, :url, :options, :item_options, :wrapper_options

    def initialize(name, *args)
      @options = args.extract_options!
      @item_options = @options.delete(:item_options) || {}
      @wrapper_options = @options.delete(:wrapper_options) || {}
      @name = name
      @url = args.first
    end
  end
end
