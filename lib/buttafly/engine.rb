module Buttafly
  class Engine < ::Rails::Engine
    isolate_namespace Buttafly

    config.generators do |g|
      g.fixture_replacement :factory_girl
    end

    config.assets.paths << File.expand_path("../../assets/stylesheets", __FILE__)
    config.assets.paths << File.expand_path("../../assets/javascripts", __FILE__)

    initializer "buttafly.assets.precompile" do |app|
      app.config.assets.precompile += %w(application.css application.js)
    end
  end
end
