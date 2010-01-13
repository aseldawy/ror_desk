require 'ruby_desk'

module ApplicationConfiguration
  require 'yaml'

  odesk_config_filename = File.join(Rails.root, 'config', 'odesk.yml')
  unless File.exists?(odesk_config_filename)
    sample_file = File.join(File.dirname(__FILE__), 'config', 'odesk.yml')
    raise "Cannot find oDesk configuration file at #{odesk_config_filename}\n"+
      "You may find a sample file at #{sample_file}"
  end
  odesk_config = YAML.load_file(odesk_config_filename)

  unless defined?(OdeskConfig)
    ::OdeskConfig = odesk_config[Rails.env]
  end

  # Include methods required to be in ApplicationController
  ActionController::Base.send :include, RorDesk::ControllerAdditions
end

