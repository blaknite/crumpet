module Crumpet
  module ControllerAdditions
    def self.included(base)
      base.extend ClassMethods
    end

    def add_crumb(*args)
      Crumpet.crumbs.add_crumb(*args)
    end

    def clear_crumbs
      Crumpet.crumbs.clear
    end

    def crumbs(&block)
      yield if block_given?
      Crumpet.crumbs
    end

    module ClassMethods
      def crumbs(&block)
        crumbs_for(&block)
      end

      def crumbs_for(*args, &block)
        if block_given?
          options = args.present? ? { only: args } : {}
          before_action(options) do |instance|
            instance.instance_exec(:crumbs, &block)
          end
        end
        Crumpet.crumbs
      end
    end
  end
end
