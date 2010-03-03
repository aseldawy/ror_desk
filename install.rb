require 'ftools'

src = File.join(File.dirname(__FILE__), 'config', 'odesk.yml')
target = File.join(Rails.root, 'config', 'odesk.yml')
File.cp src, target unless File.exists?(target)

src = File.join(File.dirname(__FILE__), 'config', 'initializers', 'ror_desk.rb')
target = File.join(Rails.roo, 'config', 'initializers')
File.cp src, target unless File.exists?(target)

