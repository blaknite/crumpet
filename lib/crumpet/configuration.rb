module Crumpet
  class Configuration
    attr_accessor :format
    attr_accessor :link
    attr_accessor :separator
    attr_accessor :default_crumb_class
    attr_accessor :first_crumb_class
    attr_accessor :last_crumb_class
    attr_accessor :link_last_crumb
    attr_accessor :truncate
    attr_accessor :escape
    attr_accessor :wrapper
    attr_accessor :default_wrapper_class
    attr_accessor :container
    attr_accessor :default_container_class

    def initialize
      @format = :html
      @link = true
      @separator = " &raquo; ".html_safe
      @default_crumb_class = nil
      @first_crumb_class = nil
      @last_crumb_class = nil
      @link_last_crumb = true
      @truncate = nil
      @escape = true
      @wrapper = nil
      @default_wrapper_class = nil
      @container = nil
      @default_container_class = nil
    end
  end
end
