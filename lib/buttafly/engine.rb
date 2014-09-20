module Buttafly
  class Engine < ::Rails::Engine
    isolate_namespace Buttafly

    config.generators do |g|
      g.fixture_replacement :factory_girl
    end
  end
end
