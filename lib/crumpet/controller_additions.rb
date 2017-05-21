module Crumpet
  module ControllerAdditions
    def self.included(base)
      base.extend ClassMethods
    end

    def add_crumb(*args)
      crumbs.add_crumb(*args)
    end

    def clear_crumbs
      crumbs.clear
    end

    def crumbs(&block)
      @_crumbs ||= Crumpet::Repository.new
    end

    module ClassMethods
      def crumbs(&block)
        crumbs_for(&block)
      end

      def crumbs_for(*args, &block)
        if block_given?
          options = args.present? ? { only: args } : {}
          before_action(options) do |instance|
            instance.instance_exec(&block)
          end
        end
      end
    end
  end
end
