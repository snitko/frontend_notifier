class FrontendNotifier < Rails::Engine

  initializer 'frontend_notifier.controller' do |app|  
    ActiveSupport.on_load(:action_controller) do  
      include FrontendNotifierControllerExtension  
      helper_method :notify_frontend
    end
  end 

end
