# Load the Rails application.
require File.expand_path('../application', __FILE__)


# Initialize the Rails application.
Sportal::Application.initialize!
module Sportal
    class Application < Rails::Application
        config.after_initialize do
        ActionController::Base.asset_host = Proc.new do |source, request|
            if request.format == 'pdf'
                "file://#{Rails.root.join('public')}"
            end
        end
    end
end
end

