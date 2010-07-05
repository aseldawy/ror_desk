config.gem('ruby_desk')
require 'ruby_desk'

config.after_initialize do
  # Redirect log messages to Rails normal log file
  RubyDesk.logger = Rails.logger if defined? RubyDesk && defined? Rails
end

module ApplicationConfiguration

  # Check that config file exists
  odesk_config_filename = File.join(Rails.root, 'config', 'odesk.yml')
  unless File.exists?(odesk_config_filename)
    sample_file = File.join(File.dirname(__FILE__), 'config', 'odesk.yml')
    raise "Cannot find oDesk configuration file at #{odesk_config_filename}\n"+
      "You may find a sample file at #{sample_file}"
  end

  # Include methods required to be in ApplicationController
  ActionController::Base.send :include, RorDesk::ControllerAdditions
  
  # Rescure from RubyDesk errors with the correct callbacks
  ActionController::Base.rescue_from ::RubyDesk::BadRequest, :with => :reaquire_token
end

