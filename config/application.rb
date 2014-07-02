require File.expand_path('../boot', __FILE__)
ENV['RANSACK_FORM_BUILDER'] = '::SimpleForm::FormBuilder'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Ads
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework false
      g.integration_tool false
      g.fixture_replacement false
      g.template_engine :slim
      g.assets false
      g.helper false
      g.jbuilder false
    end
  end
end
