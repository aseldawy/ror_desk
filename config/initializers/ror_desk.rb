# Redirect log messages to Rails normal log file
RubyDesk.logger = Rails.logger if defined? RubyDesk && defined? Rails

