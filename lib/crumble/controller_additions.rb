module Crumble
  module ControllerAdditions
    def self.included(base)
      base.extend ClassMethods
    end

    def add_crumb(name = nil, url = nil, options = {})
      Crumble.repository.add_crumb(name, url, options)
    end

    def clear_crumbs
      Crumble.repository.clear
    end

    module ClassMethods
      def crumbs(&block)
        crumbs_for(&block)
      end

      def crumbs_for(*args, &block)
        options = {}
        options[:only] = args if args.present?
        before_action(options) do |instance|
          instance.instance_exec(&block) if block_given?
        end
      end
    end
  end
end
