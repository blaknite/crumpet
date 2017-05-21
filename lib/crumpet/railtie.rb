module Crumpet
  class Railtie < Rails::Railtie
    initializer 'crumpet.setup_action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        self.class_eval do
          include Crumpet::ControllerAdditions
        end
      end
    end

    initializer 'crumpet.setup_action_view' do |app|
      ActiveSupport.on_load :action_view do
        self.class_eval do
          include Crumpet::ViewHelpers
        end
      end
    end
  end
end
