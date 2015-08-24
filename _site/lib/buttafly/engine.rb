module Buttafly
  class Engine < ::Rails::Engine
    isolate_namespace Buttafly

    config.generators do |g|
      g.fixture_replacement :factory_girl
    end

    initializer "buttafly.assets.precompile" do |app|
      app.config.assets.precompile += %w(application.css application.js)  
    end
  end
end
