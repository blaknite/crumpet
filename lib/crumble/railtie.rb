module Crumble
  class Railtie < Rails::Railtie
    initializer 'crumble.setup_action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        self.class_eval do
          include Crumble::ControllerAdditions

          before_action :clear_crumbs
        end
      end
    end

    initializer 'crumble.setup_action_view' do |app|
      ActiveSupport.on_load :action_view do
        self.class_eval do
          include Crumble::ViewHelpers
        end
      end
    end
  end
end
